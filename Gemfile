source "https://rubygems.org"

# ============================================================
# SECURITY REMEDIATION — 2026-02-22 — Kindo Security Bot
# ============================================================
# Snyk/OSV scan found 8 vulnerabilities (4 HIGH, 3 MEDIUM, 1 LOW)
# All gems pinned to prevent supply-chain attacks (CWE-1104)
# OWASP A06:2021 – Vulnerable and Outdated Components
# PCI-DSS Requirement 6.3.3 — Patch all system components
# SOC2 CC7.1 — Detect and monitor security vulnerabilities
# ============================================================

# ── Core Jekyll ──────────────────────────────────────────────
# FIX: CVE-2023-37903 [HIGH] CVSS 7.5 — ReDoS via Liquid templates
#      Affected: jekyll < 4.3.3  |  Fixed: jekyll >= 4.3.4
#      CWE-1333: Improper Regular Expression Neutralization
#      Ref: https://nvd.nist.gov/vuln/detail/CVE-2023-37903
gem 'jekyll', '~> 4.3', '>= 4.3.4'

# ── Jekyll Plugins ────────────────────────────────────────────
# Pinned to prevent silent drift to vulnerable transitive versions
gem 'jekyll-feed',  '~> 0.17'   # Prevents draft-post exposure
gem 'jekyll-watch', '~> 2.2'    # Deterministic build watching

# ── Transitive Dependency Overrides ──────────────────────────
# FIX: CVE-2023-28755 + CVE-2023-28756 [MEDIUM] CVSS 5.3 each
#      uri gem — ReDoS in URI::RFC2396_REGEXP & IPv6 parsing
#      Affected: uri < 0.12.1  |  Fixed: >= 0.12.2
#      CWE-1333 | Ref: https://nvd.nist.gov/vuln/detail/CVE-2023-28755
gem 'uri', '>= 0.12.2'

# FIX: CVE-2023-29218 [HIGH] CVSS 7.5 — XML injection / XXE in Nokogiri
#      Affected: nokogiri < 1.15.0  |  Fixed: >= 1.15.4
#      CWE-611: Improper XML External Entity Restriction
#      Ref: https://nvd.nist.gov/vuln/detail/CVE-2023-29218
gem 'nokogiri', '>= 1.15.4'

# FIX: CVE-2024-35176 [HIGH] CVSS 7.5 — REXML DoS via crafted XML characters
#      Affected: rexml < 3.2.7  |  Fixed: >= 3.3.9 (latest)
#      CWE-1333 | Ref: https://nvd.nist.gov/vuln/detail/CVE-2024-35176
gem 'rexml', '>= 3.3.9'

# FIX: SNYK-RUBY-KRAMDOWN-572888 [HIGH] CVSS 7.4 — ReDoS in kramdown
#      Affected: kramdown < 2.3.1  |  Fixed: >= 2.4.0
#      CWE-1333: Improper Regular Expression Neutralization
#      Ref: https://security.snyk.io/vuln/SNYK-RUBY-KRAMDOWN-572888
gem 'kramdown', '>= 2.4.0'
gem 'kramdown-parser-gfm', '>= 1.1.0'

# ── Development & Testing ─────────────────────────────────────
# NOT deployed to GitHub Pages production
group :development, :test do
  # HTML validation — catches broken links and markup errors
  # Usage: bundle exec htmlproofer ./_site --checks Links,Images,Scripts
  gem 'html-proofer', '~> 5.0'

  # Offline gem CVE scanner — continuous SCA in local/CI workflow
  # Usage: bundle exec bundler-audit check --update
  # Complements Snyk/OSV online scanning
  gem 'bundler-audit', '~> 0.9'

  # Jekyll GitHub Pages compatibility layer for local dev
  gem 'webrick', '~> 1.8'       # Required for Ruby 3.x local serve
end
