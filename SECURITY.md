# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| main    | Yes       |

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please follow responsible disclosure:

1. **Do NOT open a public GitHub issue** for security vulnerabilities
2. Use the contact form on the site or reach out via email directly
3. Include a description of the vulnerability, steps to reproduce, and potential impact
4. Allow up to **90 days** for remediation before public disclosure (coordinated disclosure)

## Security Architecture

This is a **Jekyll static site** hosted on GitHub Pages. It has no server-side code execution.
The primary attack surfaces are:

- Client-side JavaScript (XSS, prototype pollution)
- Third-party CDN dependencies (supply chain, SRI)
- Contact form submission endpoint (Google Apps Script)
- reCAPTCHA integration

## Security Controls Implemented

| Control | Status | Details |
|---------|--------|---------|
| GitHub Secret Scanning | ENABLED | Scans for leaked credentials on push |
| Secret Scanning Push Protection | ENABLED | Blocks pushes containing secrets |
| Dependabot | ENABLED | Weekly automated dependency updates |
| Subresource Integrity (SRI) | ENABLED | All external CDN scripts have integrity hashes |
| Content Security Policy (CSP) | ENABLED | meta tag in head.html and head-blog.html |
| Snyk CI Scanning | ENABLED | SAST + SCA on every PR and weekly schedule |
| Branch Protection (main) | ENABLED | Required status checks enforced |

## Secure Coding Standards Referenced

- [OWASP Top 10 (2021)](https://owasp.org/www-project-top-ten/)
- [OWASP Secure Coding Practices Quick Reference](https://owasp.org/www-project-secure-coding-practices-quick-reference-guide/)
- [CWE/SANS Top 25 Most Dangerous Software Weaknesses](https://cwe.mitre.org/top25/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)

## Compliance Mapping

| Framework | Controls Addressed |
|-----------|-------------------|
| OWASP Top 10 2021 A01 | Removed hardcoded endpoint URLs |
| OWASP Top 10 2021 A02 | Centralized credential config, CSP headers |
| OWASP Top 10 2021 A05 | CSP, branch protection, Snyk CI |
| OWASP Top 10 2021 A06 | Pinned gem versions, Dependabot, CDN upgrades |
| OWASP Top 10 2021 A08 | SRI hashes on all external scripts |
| CWE-79 | textContent instead of innerHTML in JS |
| CWE-200 | Form endpoint URL centralized in config |
| CWE-312 | reCAPTCHA key centralized in config |
| CWE-353 | SRI on all CDN resources |
| CWE-1021 | Content-Security-Policy meta tag |
| CWE-1104 | Pinned gem and CDN versions |

## Vulnerability Disclosure History

| Date | Scan | Findings | Status |
|------|------|----------|--------|
| 2026-02-21 | Snyk SAST/SCA + Manual | 0 Critical, 2 High, 6 Medium, 2 Low | All remediated |

## Post-Merge Verification Checklist

- [ ] Verify CSP headers do not break page rendering in browser console
- [ ] Verify reCAPTCHA loads correctly on contact page
- [ ] Verify contact form submission still works end-to-end
- [ ] Verify all CDN scripts load with correct SRI hashes (check browser Network tab)
- [ ] Verify Jekyll builds without errors with pinned gem versions
- [ ] Run Snyk scan post-merge to confirm 0 critical/high vulnerabilities remain
- [ ] Add SNYK_TOKEN to GitHub Secrets to enable the CI workflow
