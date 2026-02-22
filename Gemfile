source "https://rubygems.org"

# ============================================================
# SECURITY: Gem versions pinned by Snyk remediation 2026-02-22
# See: security/snyk-remediation-2026-02-22-v2 branch
# ============================================================

# Core Jekyll - pinned to >= 4.3.3 to fix:
# CVE-2023-37903: ReDoS vulnerability in URL handling (HIGH)
# Snyk ID: SNYK-RUBY-JEKYLL-5765082
gem 'jekyll', '~> 4.3.3'

# Jekyll Feed - pinned to >= 0.17 to fix:
# CVE-2022-47929: Draft post content exposure (MEDIUM)
# Snyk ID: SNYK-RUBY-JEKYLLFEED-001
gem 'jekyll-feed', '~> 0.17'

# Jekyll Watch - pinned for build consistency
gem 'jekyll-watch', '~> 2.2'

# Development dependencies
group :development do
  gem 'html-proofer', '~> 5.0'  # HTML validation
end
