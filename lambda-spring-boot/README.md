This is a template project for creating an AWS lambda using Java 21 and Spring Boot 3. This template contains 2 APIs that can
accessed directly from the lambda test, or we can add an API gateway method to access the APIs.

**How to optimize Java-based lambdas:**
1. Configure SnapStart for the lambda
2. Use the c1 compiler and set TieredStopAtLevel to 1.
3. Priming: Creating resources early to take advantage of the SnapStart. Initializing SDK clients, making DB calls
4. Using RDS proxy to manage DB connections. This will allow us to optimize the DB connection and prevent resource leaks.