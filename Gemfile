source "https://rubygems.org"

# ================================================================
# SECURITY REMEDIATION — 2026-02-22T11:46:00Z
# Kindo AI Security Bot | Run ID: 20260222-1146
# ----------------------------------------------------------------
# Fixes applied:
#   [HIGH] SNYK-RUBY-JEKYLL-1051000 — CVE-2018-17567
#          Arbitrary File Read via Symlink Attack
#          Fix: jekyll >= 3.6.3 → pinned to ~> 4.3, >= 4.3.4
#
#   [HIGH] CVE-2024-47220
#          WEBrick HTTP Request Smuggling (Ruby 3.x+)
#          Fix: explicit webrick ~> 1.8
#
#   [HIGH] SNYK-RUBY-REXML-7469152
#          DoS via uncontrolled XML recursion in rexml
#          Fix: explicit rexml >= 3.3.9
# ----------------------------------------------------------------
# After any gem changes run: bundle install && bundle audit check
# ================================================================

# Core Jekyll — pinned; resolves CVE-2018-17567 (requires >= 3.6.3)
gem 'jekyll', '~> 4.3', '>= 4.3.4'

# Jekyll plugins — pinned to latest audited stable releases
gem 'jekyll-feed',    '~> 0.17'   # RSS feed generation
gem 'jekyll-watch',   '~> 2.2'    # File watching for development
gem 'jekyll-seo-tag', '~> 2.8'    # SEO + security-friendly meta tags

# Security: explicit pins for transitive dependencies with known CVEs
# [HIGH] CVE-2024-47220 — Request Smuggling in WEBrick < 1.8.2
gem 'webrick', '~> 1.8', '>= 1.8.2'
# [HIGH] SNYK-RUBY-REXML-7469152 — DoS in rexml < 3.3.9
gem 'rexml',   '>= 3.3.9'

# Development / test gems
group :development, :test do
  # HTML validation and link checking in CI
  gem 'html-proofer', '~> 5.0'
  # Bundler audit: checks Gemfile.lock against advisory database
  gem 'bundler-audit', '~> 0.9'
end
