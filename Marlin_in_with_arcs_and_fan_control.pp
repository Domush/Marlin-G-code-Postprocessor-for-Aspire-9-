+================================================
+
+ gCode - Vectric machine output post-processor
+
+================================================
+
+ History
+
+ Who      When       What
+ ======== ========== ===========================
+ EdwardW   13/01/2020
+                      Added status messages (M117)
+                      Added 0:0:1mm Coord Reset (G92 X0 Y0 Z1)
+                      Added tool change support using M0
+                      Enabled Arc movements (G2/G3)
+                      Added ending presentation
+ EdwardW   28/02/2020
+                      Increased non-cut movement speed
+                      Added G54 (CNC) coordinate support
+================================================

POST_NAME = "Marlin M0 G54 Arc (in) (*.gcode)"

FILE_EXTENSION = "gcode"

UNITS = "INCHES"

+------------------------------------------------
+    Line terminating characters
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
+    Block numbering
+------------------------------------------------

LINE_NUMBER_START     = 0
LINE_NUMBER_INCREMENT = 10
LINE_NUMBER_MAXIMUM = 999999

+================================================
+
+    Formating for variables
+
+================================================

VAR LINE_NUMBER = [N|A|N|1.0]
VAR SPINDLE_SPEED = [S|A|S|1.0]
VAR FEED_RATE = [F|A|F|1.1]
VAR CUT_RATE = [FC|A|F|1.1]
VAR PLUNGE_RATE = [FP|A|F|1.1]
VAR X_POSITION = [X|C|X|1.3]
VAR Y_POSITION = [Y|C|Y|1.3]
VAR Z_POSITION = [Z|C|Z|1.3]
VAR ARC_CENTRE_I_INC_POSITION = [I|A|I|1.3]
VAR ARC_CENTRE_J_INC_POSITION = [J|A|J|1.3]
VAR X_HOME_POSITION = [XH|A|X|1.3]
VAR Y_HOME_POSITION = [YH|A|Y|1.3]
VAR Z_HOME_POSITION = [ZH|A|Z|1.3]

+================================================
+
+    Block definitions for toolpath output
+
+================================================

+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------

begin HEADER

"; [TP_FILENAME]"
"; Safe Z height: [SAFEZ]"
"; Tools: [TOOLS_USED]"
"; Notes: [FILE_NOTES]"
"; Generated [DATE] [TIME]"
"G90"
"G21"
"M0 Load [TOOLNAME], then Pos@ 0:0:0.1in"
"G54"
"G92 X0 Y0 Z0.1"
"G0 Z[SAFEZ] F800"
"G0 [XH] [YH] [F]"
"; Tool [T]: [TOOLNAME]"
"; Path: [TOOLPATH_NAME] [PATHNAME]"
"; [TOOLPATH_NOTES]"

+---------------------------------------------------
+  Commands output for rapid moves
+---------------------------------------------------

begin RAPID_MOVE

"G0 [X] [Y] [Z] [F]"

+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"G1 [X] [Y] [Z] [FC]"

+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------

begin FEED_MOVE

"G1 [X] [Y] [Z] [FC]"

+---------------------------------------------------
+ Commands output for the First Plunge Move
+---------------------------------------------------
begin FIRST_PLUNGE_MOVE

"G1 [X] [Y] [Z] [FP]"

+---------------------------------------------------
+ Commands output for Plunge Moves
+---------------------------------------------------
begin PLUNGE_MOVE

"G1 [X] [Y] [Z] [FP]"

+---------------------------------------------------
+  Commands output for the first clockwise arc move
+---------------------------------------------------

begin FIRST_CW_ARC_MOVE

"G2 [X] [Y] [I] [J] [FC]"

+---------------------------------------------------
+  Commands output for clockwise arc  move
+---------------------------------------------------

begin CW_ARC_MOVE

"G2 [X] [Y] [I] [J]"

+---------------------------------------------------
+  Commands output for the first counterclockwise arc move
+---------------------------------------------------

begin FIRST_CCW_ARC_MOVE

"G3 [X] [Y] [I] [J] [FC]"

+---------------------------------------------------
+  Commands output for counterclockwise arc  move
+---------------------------------------------------

begin CCW_ARC_MOVE

"G3 [X] [Y] [I] [J]"

+---------------------------------------------------
+  Commands output for tool changes
+---------------------------------------------------

begin TOOLCHANGE

"; Tool change:"
"; Tool [T]: [TOOLNAME]"
"M0 Load [TOOLNAME], then Pos@ 0:0:0.1in"

+---------------------------------------------------
+  Commands output for toolpath changes
+---------------------------------------------------

begin NEW_SEGMENT

"M117 Resuming [TOOLPATH_NAME] using [TOOLNAME]"
"G54"
"G92 Z0.1"
"G0 Z[SAFEZ] F800"
"G0 X0 Y0"

+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------

begin FOOTER

"G0 Z[SAFEZ] F800"
"G0 X0 Y0 F3000"
"M117 Routing complete <3"
