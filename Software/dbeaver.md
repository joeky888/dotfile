Dark theme and font
=====
* Window -> Preferences -> User Interface -> Appearance -> Theme: Dark
* Window > Preferences > User Interface > Appearance > Colors and Fonts > DBeaver Fonts > Monospace font

Read-Only connection and Production connection
=====
* Right-Click a connection on the left -> Edit Connection -> General ->
  * Connection type -> Production
  * Read-only connection -> Check

Export (source) table and import to (target) local table
=====
* Right-Click the (source) tables to be exported ->
  * Generate SQL -> DDL
  * Export Data
    * Export target -> SQL
    * Extraction settings -> keep defaults
    * Format settings -> Include generated columns -> Check
    * Output -> keep defaults
    * Confirm -> Proceed button
