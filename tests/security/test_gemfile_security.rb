#!/usr/bin/env ruby
# frozen_string_literal: true

# =============================================================================
# Security Regression Test Suite
# =============================================================================
# Tests verify CVE remediations and security configurations remain in place.
# Run: ruby tests/security/test_gemfile_security.rb
#
# Covers:
#   - CVE-2018-17567: jekyll directory traversal (GHSA-4xjh-m3qx-49wc)
#   - CVE-2021-28834: kramdown RCE (GHSA-52p9-v744-mwjj)
#   - CVE-2020-14001: kramdown template injection (GHSA-mqm2-cgpr-p4m6)
#   - CWE-829: Supply chain (all gems pinned)
#   - SAST: _config.yml credential exposure
# =============================================================================

require 'minitest/autorun'
require 'minitest/reporters'
require 'rubygems/version'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class SecurityRegressionTest < Minitest::Test

  GEMFILE_PATH = File.join(File.dirname(__FILE__), '../../Gemfile')
  CONFIG_PATH  = File.join(File.dirname(__FILE__), '../../_config.yml')

  def setup
    @gemfile_content = File.read(GEMFILE_PATH)
    @config_content  = File.read(CONFIG_PATH)
  end

  # ---------------------------------------------------------------------------
  # CVE-2018-17567 Regression: jekyll >= 4.3.4
  # GHSA-4xjh-m3qx-49wc | CVSS 7.5 HIGH
  # Directory traversal via symlink following in Jekyll dev server
  # Vulnerable: < 3.6.3 | Fixed: >= 3.6.3 | Pinned to: >= 4.3.4
  # ---------------------------------------------------------------------------
  def test_cve_2018_17567_jekyll_version_pinned
    # Verify jekyll is present in Gemfile
    assert @gemfile_content.include?("gem 'jekyll'"),
           "jekyll gem must be declared in Gemfile"

    # Verify jekyll has a version constraint
    jekyll_line = @gemfile_content.lines.find { |l| l.match?(/^gem 'jekyll'/) }
    assert jekyll_line, "jekyll gem declaration not found in Gemfile"

    # Verify the version is >= 4.3.4 (safe from CVE-2018-17567)
    version_match = jekyll_line.match(/>= ([\d.]+)/)
    assert version_match, "jekyll must have a minimum version constraint (>= X.X.X)"

    pinned_version = Gem::Version.new(version_match[1])
    safe_version   = Gem::Version.new('4.3.4')

    assert pinned_version >= safe_version,
           "REGRESSION: jekyll must be pinned to >= 4.3.4 (CVE-2018-17567). " \
           "Currently: >= #{version_match[1]}"
  end

  # ---------------------------------------------------------------------------
  # CVE-2021-28834 + CVE-2020-14001 Regression: kramdown >= 2.3.1
  # GHSA-52p9-v744-mwjj | CVSS 9.8 CRITICAL — RCE
  # GHSA-mqm2-cgpr-p4m6 | CVSS 9.8 CRITICAL — Template injection
  # Vulnerable: < 2.3.0 | Fixed: >= 2.3.1
  # ---------------------------------------------------------------------------
  def test_cve_2021_28834_kramdown_rce_pinned
    # Verify kramdown is explicitly declared (not just a transitive dep)
    assert @gemfile_content.include?("gem 'kramdown'"),
           "kramdown MUST be explicitly declared in Gemfile with version pin " \
           "(CVE-2021-28834, CVE-2020-14001 — RCE vulnerabilities)"

    kramdown_line = @gemfile_content.lines.find { |l| l.match?(/^gem 'kramdown'/) }
    assert kramdown_line, "kramdown gem declaration not found"

    version_match = kramdown_line.match(/>= ([\d.]+)/)
    assert version_match, "kramdown must have a minimum version constraint"

    pinned_version = Gem::Version.new(version_match[1])
    safe_version   = Gem::Version.new('2.3.1')

    assert pinned_version >= safe_version,
           "REGRESSION: kramdown must be pinned to >= 2.3.1 " \
           "(CVE-2021-28834 RCE + CVE-2020-14001). Currently: >= #{version_match[1]}"
  end

  # ---------------------------------------------------------------------------
  # Supply Chain Security: All gems must have version constraints (CWE-829)
  # OWASP A06:2021 — Vulnerable and Outdated Components
  # ---------------------------------------------------------------------------
  def test_supply_chain_all_gems_pinned
    unpinned_gems = []

    @gemfile_content.each_line do |line|
      # Match gem declarations without version: gem 'name' (with optional comment)
      if (match = line.match(/^gem\s+'([^']+)'\s*(?:#.*)?$/))
        unpinned_gems << match[1]
      end
    end

    assert_empty unpinned_gems,
                 "SUPPLY CHAIN RISK (CWE-829): The following gems have no version " \
                 "constraints: #{unpinned_gems.join(', ')}. " \
                 "All gems must be pinned to prevent supply chain attacks."
  end

  # ---------------------------------------------------------------------------
  # SAST: _config.yml — No credential field exposure
  # OWASP A02:2021 — Cryptographic Failures
  # ---------------------------------------------------------------------------
  def test_config_no_exposed_credentials
    # Check gitalk_client_id is not populated
    config_lines = @config_content.lines.reject { |l| l.strip.start_with?('#') }

    client_id_line = config_lines.find { |l| l.match?(/^gitalk_client_id:/) }
    if client_id_line
      value = client_id_line.split(':', 2).last.strip
      assert value.empty?,
             "SECURITY FAIL: gitalk_client_id is populated in public _config.yml! " \
             "This exposes OAuth credentials. Use GitHub Secrets instead."
    end

    client_secret_line = config_lines.find { |l| l.match?(/^gitalk_client_secret:/) }
    if client_secret_line
      value = client_secret_line.split(':', 2).last.strip
      assert value.empty?,
             "SECURITY FAIL: gitalk_client_secret is populated in public _config.yml! " \
             "OAuth credentials MUST be stored in GitHub Secrets, not config files."
    end
  end

  # ---------------------------------------------------------------------------
  # IaC: SECURITY.md must exist (security policy documentation)
  # ---------------------------------------------------------------------------
  def test_security_policy_file_exists
    security_md = File.join(File.dirname(__FILE__), '../../SECURITY.md')
    assert File.exist?(security_md),
           "SECURITY.md must exist. Security policy documentation is required " \
           "for vulnerability disclosure and credential management guidance."
  end

  # ---------------------------------------------------------------------------
  # Test: Gemfile source is HTTPS (not HTTP — supply chain risk)
  # ---------------------------------------------------------------------------
  def test_gemfile_source_uses_https
    source_line = @gemfile_content.lines.find { |l| l.start_with?('source') }
    assert source_line, "Gemfile must have a source declaration"
    assert source_line.include?('https://'),
           "SECURITY: Gemfile source must use HTTPS to prevent MITM attacks. " \
           "Found: #{source_line.strip}"
    refute source_line.include?('http://') && !source_line.include?('https://'),
           "SECURITY: Gemfile source must not use plain HTTP"
  end

  # ---------------------------------------------------------------------------
  # Test: jekyll-feed version pin (defense-in-depth — GHSA-4g8v-vg43-wpgf)
  # ---------------------------------------------------------------------------
  def test_jekyll_feed_version_pinned
    feed_line = @gemfile_content.lines.find { |l| l.match?(/^gem 'jekyll-feed'/) }
    assert feed_line, "jekyll-feed gem must be declared in Gemfile"

    version_match = feed_line.match(/>= ([\d.]+)/)
    assert version_match, "jekyll-feed must have a minimum version constraint"

    pinned_version = Gem::Version.new(version_match[1])
    safe_version   = Gem::Version.new('0.17.0')

    assert pinned_version >= safe_version,
           "jekyll-feed should be pinned to >= 0.17.0 (XSS defense-in-depth). " \
           "Currently: >= #{version_match[1]}"
  end

end
