#!/usr/bin/env ruby
# frozen_string_literal: true
# ===========================================================================
# SECURITY REGRESSION TESTS — bwilliams003.github.io
# Created: 2026-02-22 | Kindo AI Security Bot
# Purpose: Validate that all Snyk-identified security fixes are in place
#          and prevent regressions in future commits.
# ===========================================================================
# Run: bundle exec ruby tests/security/test_security_headers.rb
# CI:  Executed automatically in .github/workflows/security-scan.yml
# ===========================================================================

require 'minitest/autorun'
require 'yaml'
require 'json'

class TestSecurityHeaders < Minitest::Test
  HEADERS_FILE = File.join(File.dirname(__FILE__), '../../_headers')
  CONFIG_FILE  = File.join(File.dirname(__FILE__), '../../_config.yml')
  GEMFILE      = File.join(File.dirname(__FILE__), '../../Gemfile')

  def setup
    @headers_content = File.read(HEADERS_FILE) if File.exist?(HEADERS_FILE)
    @config = YAML.safe_load(File.read(CONFIG_FILE)) if File.exist?(CONFIG_FILE)
    @gemfile = File.read(GEMFILE) if File.exist?(GEMFILE)
  end

  # =========================================================================
  # SAST REGRESSION TESTS — Fixes: SNYK-JS-001, SNYK-JS-002, SNYK-SECRET-001
  # =========================================================================

  def test_no_document_write_in_html
    # SNYK-JS-001: DOM XSS via document.write()
    html_files = Dir.glob('**/*.html').reject { |f| f.include?('vendor') || f.include?('node_modules') }
    html_files.each do |file|
      content = File.read(file)
      refute_match(/document\.write\s*\(/, content,
        "SECURITY FAIL [SNYK-JS-001]: document.write() found in #{file} — DOM XSS risk")
    end
  end

  def test_no_eval_in_html_or_js
    # SNYK-JS-002: eval() with user-controlled data
    files = Dir.glob('**/*.{html,js}').reject { |f| f.include?('vendor') || f.include?('node_modules') }
    files.each do |file|
      content = File.read(file)
      refute_match(/\beval\s*\(/, content,
        "SECURITY FAIL [SNYK-JS-002]: eval() found in #{file} — RCE risk")
    end
  end

  def test_no_hardcoded_secrets
    # SNYK-SECRET-001: Hardcoded API keys / credentials
    secret_patterns = [
      /sk-[a-zA-Z0-9]{20,}/,           # OpenAI/API key pattern
      /api[_-]?key\s*[:=]\s*["'][^"']+["']/i,  # Generic API key assignment
      /password\s*[:=]\s*["'][^"']+["']/i,     # Hardcoded passwords
      /client_secret\s*[:=]\s*["'][^"']+["']/i  # OAuth secrets
    ]
    code_files = Dir.glob('**/*.{html,js,rb,yml,yaml}').reject { |f|
      f.include?('vendor') || f.include?('node_modules') || f.include?('test')
    }
    code_files.each do |file|
      content = File.read(file)
      secret_patterns.each do |pattern|
        refute_match(pattern, content,
          "SECURITY FAIL [SNYK-SECRET-001]: Potential hardcoded secret detected in #{file}")
      end
    end
  end

  def test_no_http_cdn_resources
    # Regression: all CDN resources must use HTTPS (prevents MITM/XSS)
    html_files = Dir.glob('**/*.html').reject { |f| f.include?('vendor') }
    html_files.each do |file|
      content = File.read(file)
      refute_match(/src=["']http:\/\//, content,
        "SECURITY FAIL: HTTP (non-HTTPS) CDN resource found in #{file} — MITM risk")
    end
  end

  # =========================================================================
  # IAC / SECURITY HEADERS TESTS — Fixes: SNYK-JEKYLL-HEADERS-001, CSP-001
  # =========================================================================

  def test_headers_file_exists
    # SNYK-JEKYLL-HEADERS-001: Security headers must be configured
    assert File.exist?(HEADERS_FILE),
      "SECURITY FAIL [SNYK-JEKYLL-HEADERS-001]: _headers file is missing — deploy security headers"
  end

  def test_x_frame_options_deny
    # Prevents clickjacking (CWE-1021)
    skip "No _headers file" unless @headers_content
    assert_match(/X-Frame-Options:\s*DENY/i, @headers_content,
      "SECURITY FAIL: X-Frame-Options: DENY is missing — clickjacking vulnerability")
  end

  def test_x_content_type_options_nosniff
    # Prevents MIME type sniffing
    skip "No _headers file" unless @headers_content
    assert_match(/X-Content-Type-Options:\s*nosniff/i, @headers_content,
      "SECURITY FAIL: X-Content-Type-Options: nosniff is missing — MIME sniffing risk")
  end

  def test_strict_transport_security_present
    # Enforces HTTPS (CWE-319)
    skip "No _headers file" unless @headers_content
    assert_match(/Strict-Transport-Security:/i, @headers_content,
      "SECURITY FAIL: HSTS header missing — SSL stripping attack possible")
    assert_match(/max-age=\d+/i, @headers_content,
      "SECURITY FAIL: HSTS max-age not configured")
  end

  def test_content_security_policy_present
    # SNYK-JEKYLL-CSP-001: CSP must be configured (mitigates XSS)
    skip "No _headers file" unless @headers_content
    assert_match(/Content-Security-Policy:/i, @headers_content,
      "SECURITY FAIL [SNYK-JEKYLL-CSP-001]: Content-Security-Policy is missing — XSS escalation risk")
  end

  def test_csp_no_unsafe_eval
    # CSP must not allow 'unsafe-eval' (enables XSS)
    skip "No _headers file" unless @headers_content
    refute_match(/'unsafe-eval'/, @headers_content,
      "SECURITY FAIL: CSP contains 'unsafe-eval' — this negates XSS protection")
  end

  def test_csp_object_src_none
    # Disables Flash/plugin vectors
    skip "No _headers file" unless @headers_content
    assert_match(/object-src\s+'none'/, @headers_content,
      "SECURITY FAIL: CSP object-src 'none' missing — plugin-based attacks possible")
  end

  def test_referrer_policy_present
    # Prevents referrer leakage
    skip "No _headers file" unless @headers_content
    assert_match(/Referrer-Policy:/i, @headers_content,
      "SECURITY FAIL: Referrer-Policy header missing — URL leakage risk")
  end

  def test_permissions_policy_present
    # Disables dangerous browser APIs
    skip "No _headers file" unless @headers_content
    assert_match(/Permissions-Policy:/i, @headers_content,
      "SECURITY FAIL: Permissions-Policy header missing — camera/mic/geolocation APIs exposed")
  end

  # =========================================================================
  # SCA TESTS — Fixes: SNYK-RUBY-JEKYLL-6096861
  # =========================================================================

  def test_jekyll_version_pinned
    # SNYK-RUBY-JEKYLL-6096861: Jekyll must be pinned to >= 4.3.2
    skip "No Gemfile" unless @gemfile
    assert_match(/gem\s+['"]jekyll['"].*['"].*4\.[3-9]/, @gemfile,
      "SECURITY FAIL [SNYK-RUBY-JEKYLL-6096861]: Jekyll not pinned to >= 4.3.2")
  end

  def test_no_unpinned_gems
    # All gems in Gemfile should have version constraints
    skip "No Gemfile" unless @gemfile
    gem_lines = @gemfile.lines.select { |l| l.strip.start_with?("gem ") }
    gem_lines.each do |line|
      next if line.include?('#')  # skip comments
      assert_match(/',\s*['"~><=]/, line,
        "SECURITY WARN: Unpinned gem found: #{line.strip} — use version constraints")
    end
  end

  # =========================================================================
  # CONFIG SECURITY TESTS — Fixes: SNYK-JEKYLL-001, SNYK-JEKYLL-002
  # =========================================================================

  def test_dns_prefetch_disabled
    # SNYK-JEKYLL-002: DNS prefetch is a privacy risk
    skip "No _config.yml" unless @config
    dns_setting = @config['x-dns-prefetch-control']
    assert_equal 'off', dns_setting.to_s.downcase,
      "SECURITY FAIL [SNYK-JEKYLL-002]: x-dns-prefetch-control should be 'off'"
  end

  def test_help_tips_disabled
    # SNYK-JEKYLL-001: Debug info must not leak in production
    skip "No _config.yml" unless @config
    refute @config['help_tips'],
      "SECURITY FAIL: help_tips must be false in production to prevent info disclosure"
  end
end

# ===========================================================================
# HTMLProofer Integration Tests
# Run with: bundle exec htmlproofer ./_site --check-html --check-sri
# These validate that the built site has:
#   - Subresource Integrity (SRI) on all CDN scripts
#   - No broken internal links
#   - Valid HTML structure
#   - No mixed content (HTTP resources on HTTPS page)
# ===========================================================================
class TestHTMLProofer < Minitest::Test
  def test_sri_integrity_documented
    # Verify that CDN script tags in layouts use integrity attributes
    layout_files = Dir.glob('_layouts/**/*.html') + Dir.glob('_includes/**/*.html')
    layout_files.each do |file|
      content = File.read(file)
      if content.match?(/src=["']https?:\/\/[^"']+\.js["']/)
        # If any external JS is loaded, it should have integrity attribute
        # Note: FontAwesome kits use dynamic loading - document exemption
        unless content.include?('kit.fontawesome.com') || content.include?('# SRI-exempt')
          assert_match(/integrity=["']sha/, content,
            "SECURITY WARN: External JS in #{file} should use SRI (Subresource Integrity)")
        end
      end
    end
  end
end
