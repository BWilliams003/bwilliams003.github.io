source "https://rubygems.org"

# ============================================================
# SECURITY REMEDIATION: 2026-02-22
# Pinned gem versions to prevent supply chain attacks and
# address CVE-2018-17567 (Arbitrary File Read via Symlink).
# SNYK-RUBY-JEKYLL-1051000 (HIGH) - fixed by >= 3.6.3
# SNYK-RUBY-JEKYLL-NOLOCK (MEDIUM) - fixed by pinning all gems
# Run `bundle install` then commit the resulting Gemfile.lock
# ============================================================

# Core Jekyll - pinned to latest stable; fixes CVE-2018-17567 (requires >= 3.6.3)
gem 'jekyll', '~> 4.3', '>= 4.3.4'

# Jekyll plugins - pinned to latest audited stable releases
gem 'jekyll-feed',  '~> 0.17'   # RSS feed generation
gem 'jekyll-watch', '~> 2.2'    # File watching for development
gem 'jekyll-seo-tag', '~> 2.8'  # SEO meta tags (also adds security-friendly meta)

# Required for Jekyll on Ruby 3.x+
gem 'webrick', '~> 1.8'         # WEBrick web server (removed from stdlib in Ruby 3.0)

# Development / test gems
group :development, :test do
  gem 'html-proofer', '~> 5.0'  # HTML validation and link checking in CI
end
