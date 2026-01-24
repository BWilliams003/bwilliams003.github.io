---
layout: article
title: "Understanding the CIA Triad"
date: 2024-02-09
description: 
---

*This article contains a short description of each part of the CIA Triad – Confidentiality, Integrity, and Availability. The concepts of authentication and authorization are also described, and examples of both terms are provided.*

### CIA Triad Overview
The CIA Triad stands for Confidentiality, Integrity, and Availability, which are “the pillars of information security” (Cawthra et al., 2020). Confidentiality is measured by how protected sensitive data is from unauthorized access attempts, as well as how catastrophic it would be for the data to be accessed by an unauthorized person (Chai, 2022). Integrity is measured by how secure information is from unauthorized altering, as well as how catastrophic it would be for the data to be altered in an unauthorized way. Finally, Availability is measured by how readily available data is for authorized parties, as well as how catastrophic it would be for the data to not be readily available when needed.

### Authentication vs. Authorization
Authentication is defined as “the process of proving that you’re who you say you are” (Authentication vs. Authorization, 2023). Users can be authenticated in a variety of different ways, which are commonly described as something you have, something you are, or something you know (Rublon Authors, 2021). Something you have includes a hardware token or a device you have access to, like a smartphone a verification code can be sent to. Something you are is the practice of authenticating using biometric data, like your fingerprint or facial recognition. Lastly, something you know may be a password or security question. Using multiple types of authentications to authenticate a user is the practice of multifactor authentication.

Authorization is defined as “the act of granting an authenticated party permission to do something” (Authentication vs. Authorization, 2023). An authenticated user can only access the data and resources the system administrator has authorized them to access. This can be managed in a couple of ways: conditional access, least privileged access, and zero trust (Describe Authorization Security Techniques, n.d.). Conditional access can limit the access of authenticated users by assessing other factors. For example, a company may only authorize an authenticated user to access the payroll system through a corporate computer.  Least privilege access is the practice of only authorizing authenticated users to the bare minimum resources required for them to complete their assigned responsibilities. For example, if a user only needs to read a file, they are only authorized to read it, not to edit or relocate the file. Zero trust is the practice of authenticating and authorizing the user every time they try to access anything. Zero trust also utilizes the principle of least privilege access.

### Conclusion
In conclusion, the CIA Triad describes the pillars of information security. These pillars, confidentiality, integrity, and authentication, guide organizations in how to implement security practices to best protect their data, depending on which of the pillars is most important for the data or is the weakest for the organization. Authentication is the process of ensuring the user attempting to access the system is who they say they are, while authorization describes the process of granting access to authenticated users.

### References

*Authentication vs. Authorization*. (2023, October 23). Microsoft Learn. [https://learn.microsoft.com/en-us/entra/identity-platform/authentication-vs-authorization](https://learn.microsoft.com/en-us/entra/identity-platform/authentication-vs-authorization)

Cawthra, J., Ekstrom, M., Lusty, L., Sexton, J., Sweetnam, J., & Townsend, A. (2020, December). *NIST Special Publication 1800-26A: Data Integrity: Detecting and Responding to Ransomware and Other Destructive Events*. [https://www.nccoe.nist.gov/publication/1800-26/VolA/index.html](https://www.nccoe.nist.gov/publication/1800-26/VolA/index.html)

Chai, W. (2022, June 28). *What is the CIA Triad? Definition, Explanation, Examples*. TechTarget. [https://www.techtarget.com/whatis/definition/Confidentiality-integrity-and-availability-CIA](https://www.techtarget.com/whatis/definition/Confidentiality-integrity-and-availability-CIA)

*Describe authorization security techniques*. (n.d.). Microsoft Learn. [https://learn.microsoft.com/en-us/training/modules/describe-authentication-authorization-cybersecurity/4-describe-authorization-security-techniques](https://learn.microsoft.com/en-us/training/modules/describe-authentication-authorization-cybersecurity/4-describe-authorization-security-techniques)

Rublon Authors. (2021, December 14). *What are the three authentication factors?* Rublon. [https://rublon.com/blog/what-are-the-three-authentication-factors/](https://rublon.com/blog/what-are-the-three-authentication-factors/)