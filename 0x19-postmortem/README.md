# **Postmortem Report**

![Postmortem](postmortem.gif)

## **Issue Summary**
- **Duration of the Outage:**
  - **Start Time:** 2024-08-22, 14:00 GMT
  - **End Time:** 2024-08-22, 16:30 GMT
  - **Total Duration:** 2 hours 30 minutes
  
- **Impact:**
  - **Service Affected:** Online Payment Gateway
  - **User Impact:** During the outage, users were unable to process payments. Approximately 65% of the users were affected, leading to significant delays and customer dissatisfaction.
  
- **Root Cause:**
  - A misconfigured Nginx server setting led to a failure in handling SSL termination, causing the payment processing service to fail under increased load.

## **Timeline**
- **14:00 UTC:** Issue detected via an automated monitoring alert indicating that the payment gateway response times were unusually high.
- **14:05 UTC:** Initial investigation focused on database performance, suspecting a potential query bottleneck.
- **14:15 UTC:** Shifted focus to the application server as no database issues were found. Checked for high memory or CPU usage.
- **14:30 UTC:** Misleading paths included assumptions about network latency. Networking team was consulted, but no abnormalities were found.
- **14:45 UTC:** Escalation to the DevOps team to check the server configuration. Discovered that a recent update to the Nginx configuration was not properly tested.
- **15:00 UTC:** Root cause identified as a misconfiguration in the Nginx SSL settings that prevented proper load balancing.
- **15:30 UTC:** Applied a hotfix to the Nginx configuration and restarted the server.
- **16:00 UTC:** Verified that the service was fully operational.
- **16:30 UTC:** Official end of the incident after confirming stability.

## **Root Cause and Resolution**
- **Root Cause:**
  - The root cause of the outage was a misconfigured Nginx server responsible for SSL termination. The configuration error occurred during a recent update intended to improve security by enforcing stricter SSL protocols. However, the settings conflicted with existing load balancing rules, leading to SSL handshake failures under heavy traffic.
  
- **Resolution:**
  - The Nginx configuration was reviewed, and the conflicting SSL settings were corrected. The server was then restarted to apply the changes. Additionally, the configuration was tested in a staging environment before deploying it to production to prevent similar issues in the future.

## **Corrective and Preventative Measures**
- **Improvements/Fixes:**
  - Conduct thorough testing of server configuration changes in a staging environment before production deployment.
  - Implement a rollback plan for critical configuration changes to minimize downtime in case of failure.
  - Enhance monitoring tools to include specific alerts for SSL handshake failures and server configuration issues.
  
- **Tasks:**
  - Patch the Nginx server with the updated configuration.
  - Add SSL handshake monitoring to the existing server monitoring setup.
  - Document the incident and the changes made in the internal knowledge base.
  - Schedule a training session for the DevOps team on best practices for server configuration management.

## **Photos**

![Insert Photo Description Here](link-to-your-photo2)
