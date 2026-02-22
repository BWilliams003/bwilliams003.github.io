# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| main (latest) | ✅ Active |

## Reporting a Vulnerability

**Please do NOT open a public GitHub issue for security vulnerabilities.**

If you discover a security vulnerability in this project, please report it responsibly:

### Contact

- **Email**: [Use GitHub's private vulnerability reporting](https://github.com/BWilliams003/bwilliams003.github.io/security/advisories/new)
- **Response Time**: We aim to respond within **48 hours** of receiving a report
- **Resolution Target**: Critical/High severity issues within **7 days**, Medium/Low within **30 days**

### What to Include

Please include the following in your report:

1. **Description** of the vulnerability
2. **Steps to reproduce** (proof-of-concept if available)
3. **Potential impact** assessment
4. **Suggested fix** (optional but appreciated)

### What to Expect

1. **Acknowledgment** within 48 hours
2. **Confirmation** of the vulnerability (or explanation if not reproducible)
3. **Timeline** for the fix
4. **Credit** in the release notes (if desired)

## Security Best Practices for Contributors

### Secrets & Credentials
- **Never commit** API keys, OAuth secrets, tokens, or passwords to this repository
- Use [GitHub Secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets) for CI/CD credentials
- The GitTalk `client_secret` field in `_config.yml` must remain empty; use environment injection

### Dependencies
- All Ruby gems must be **version-pinned** in `Gemfile`
- `Gemfile.lock` must be committed and kept up to date
- Run `bundle exec bundler-audit check --update` before submitting PRs
- CDN-loaded JavaScript must include **SRI (Subresource Integrity)** hashes

### Content Security Policy
- The site enforces a CSP via `<meta http-equiv="Content-Security-Policy">` in `_includes/head.html`
- Any new CDN resources must be added to the CSP allowlist in that file

## Compliance References

This project considers the following frameworks:

- [OWASP Top 10 (2021)](https://owasp.org/Top10/)
- [OWASP Secure Coding Practices](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [GitHub Security Hardening Guide](https://docs.github.com/en/code-security)

## Automated Security Scanning

This repository uses automated security tooling:

- **Snyk** — Dependency vulnerability scanning (SCA)
- **Kindo AI Security Bot** — Automated SAST/SCA/IaC scanning and remediation PR generation
- **bundler-audit** — Ruby gem CVE checking

---

*This security policy was established on 2026-02-22 as part of the Snyk remediation initiative.*
