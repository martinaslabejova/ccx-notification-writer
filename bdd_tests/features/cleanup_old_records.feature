Feature: Ability to clean up old records stored in database


  Scenario: Check the ability to clean up old records from `new_reports` table if the table is empty.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
     When I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to clean up old records from `reported` table if the table is empty.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
     When I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to clean up old records from `new_reports` table if the table contains one old report.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
      And I insert following row into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
     When I select all rows from table new_reports
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to clean up old records from `new_reports` table if the table contains two old reports.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
      And I insert following rows into table new_reports
          | org id |  account number | cluster name                         | updated at  | kafka offset |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 1            |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1990-01-01  | 2            |
     When I select all rows from table new_reports
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --new-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table new_reports
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to clean up old records from `reported` table if the table contains one old report.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
      And I insert following row into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   |           |
     When I select all rows from table reported
     Then I should get 1 row
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0


  Scenario: Check the ability to clean up old records from `reported` table if the table contains two old reports.
    Given Postgres is running
      And CCX Notification Writer database is created for user postgres with password postgres
      And CCX Notification Writer database is empty
      And I insert following rows into table reported
          | org id |  account number | cluster name                         | notification type | state | updated at  | notified at  | error log |
          | 1      |  10             | 5d5892d4-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   |           |
          | 2      |  20             | aaaaaaaa-1f74-4ccf-91af-548dfc9767aa | 1                 | 1     | 1990-01-01  | 1990-01-01   |           |
     When I select all rows from table reported
     Then I should get 2 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --old-reports-cleanup command line flag
     Then the process should exit with status code set to 0
     When CCX Notification Writer database is created for user postgres with password postgres
      And I select all rows from table reported
     Then I should get 0 rows
     When I close database connection
     Then I should be disconnected
     When I start the CCX Notification Writer with the --db-drop-tables command line flag
     Then the process should exit with status code set to 0
