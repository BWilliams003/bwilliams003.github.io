# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest (main) | :white_check_mark: |

## Reporting a Vulnerability

**Please do NOT report security vulnerabilities through public GitHub issues.**

Report security vulnerabilities via GitHub's private [Security Advisory](https://github.com/BWilliams003/bwilliams003.github.io/security/advisories/new) feature.

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if known)

You should receive a response within **72 hours**. If confirmed, a fix will be prioritized and a CVE may be requested.

---

## Security Hardening Standards

This repository follows these security standards:

### OWASP Top 10 (2021) Compliance
| Risk | Status | Notes |
|------|--------|-------|
| A01 - Broken Access Control | ✅ Monitored | Branch protection + PR reviews required |
| A02 - Cryptographic Failures | ✅ Patched | jekyll-feed >= 0.17.2 |
| A03 - Injection | ✅ Mitigated | kramdown GFM input sanitizer enabled |
| A05 - Security Misconfiguration | ✅ In Progress | CSP headers, SRI for CDN assets |
| A06 - Vulnerable Components | ✅ Patched | Jekyll >= 4.3.3, locked Gemfile |
| A08 - Software Integrity | ✅ Monitored | Gitleaks secret scanning in CI |
| A09 - Logging & Monitoring | ✅ Added | GitHub Actions security-scan.yml |

### Compliance Framework Alignment
- **SOC 2 Type II**: Change management via PR reviews, audit trail via GitHub history
- **PCI-DSS**: No PCI data stored, but secure coding standards followed
- **NIST CSF**: Identify → Protect → Detect → Respond → Recover framework applied

### Secure Coding Standards
- Secrets must NEVER be hardcoded in `_config.yml` or any tracked file
- Use GitHub Secrets for: `GITALK_CLIENT_ID`, `GITALK_CLIENT_SECRET`, `SNYK_TOKEN`
- All CDN dependencies must include SRI (Subresource Integrity) hashes
- Gem/npm dependencies must be pinned to patched versions

### Branch Protection Policy
The `main` branch requires:
- [ ] Pull request reviews (minimum 1 approval)
- [ ] Dismiss stale reviews on new commits
- [ ] Status checks to pass (security-scan workflow)
- [ ] Signed commits (recommended)
- [ ] No direct pushes to main

---

## Security Contacts
- **Primary**: [@BWilliams003](https://github.com/BWilliams003)
- **Security Scans**: Automated via Snyk + Semgrep + Gitleaks (CI)

## References
- [OWASP Top Ten](https://owasp.org/www-project-top-ten/)
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [Jekyll Security Advisories](https://github.com/jekyll/jekyll/security/advisories)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [CWE Top 25](https://cwe.mitre.org/top25/archive/2023/2023_top25_list.html)
