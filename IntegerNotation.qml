//==============================================
//  Integer Notation & Numbered Notation plugin for MuseScore v4
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//==============================================

import QtQuick 2.9
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import MuseScore 3.0
import Qt.labs.settings 1.0

MuseScore {
    id: mainWindow
    menuPath: "Plugins." + qsTr("Integer Notation")
    version: "0.1.0"
    description: qsTr("Add Integer Notation or Numbered Notation of the notes below the staves")
    pluginType: "dialog"
    width: 300  // menu window size
    height: 500

    Component.onCompleted: {
        if (mscoreMajorVersion >= 4) {
            title = qsTr("Integer Notation");
        }
    }

    ExclusiveGroup {
        id: exclusiveGroupKey
    }

    property var fontFamily: "Arial Narrow"

    ColumnLayout {
        id: column1
        x: 10
        y: 10
        width: parent.width - 20
        height: parent.height - 20

        RowLayout {
            id: rowFormat
            width: parent.width
            Label {
                text: "Notation format"
                Layout.fillWidth: true
            }
            ComboBox {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    id: inputNotationFormat
                    property var key
                    ListElement {
                        text: "0~11"
                        fName: 0
                    }
                    ListElement {
                        text: "1~7,♯"
                        fName: 1
                    }
                    ListElement {
                        text: "1~7,♭"
                        fName: 2
                    }
                }
                onCurrentIndexChanged: {
                    inputNotationFormat.key = inputNotationFormat.get(currentIndex).fName;
                }
            }
        }

        RowLayout {
            Label {
                text: "Reference Note (MIDI num C4=60)"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputReferenceNote
                implicitWidth: 55
                decimals: 0
                minimumValue: 0
                maximumValue: 127
                value: 60
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: findKeySignature()
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: "Part"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                model: ListModel {
                    id: inputPart
                    property var key
                    ListElement {
                        text: "Part 1"
                        pName: 0
                    }
                    ListElement {
                        text: "Part 2"
                        pName: 1
                    }
                    ListElement {
                        text: "Part 3"
                        pName: 2
                    }
                    ListElement {
                        text: "Part 4"
                        pName: 3
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
                onCurrentIndexChanged: {
                    inputPart.key = inputPart.get(currentIndex).pName;
                }
            }
        }
        RowLayout {
            Label {
                text: "Font Size"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputFontSize
                implicitWidth: 55
                decimals: 0
                minimumValue: 4
                maximumValue: 36
                value: 10
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Line spacing (no effect yet)"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputLineSpacing
                implicitWidth: 55
                decimals: 2
                minimumValue: 0.5
                maximumValue: 1.5
                value: 0.9
                stepSize: 0.05
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "X offset"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputXOffset
                implicitWidth: 55
                decimals: 1
                minimumValue: -5
                maximumValue: 5
                value: 1
                stepSize: 0.1
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Y offset"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputYOffset
                implicitWidth: 55
                decimals: 0
                minimumValue: -20
                maximumValue: 30
                value: 4
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Color (RGB value)"
                Layout.fillWidth: true
            }
            TextField {
                id: inputFontColor
                text: "#000000"
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                font.pointSize: 10
                text: "v" + version
                Layout.fillWidth: true
            }
            Button {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 80
                text: "Cancel"
                onClicked: {
                    quit();
                }
            }
            Button {
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 80
                text: "Ok"
                onClicked: {
                    curScore.startCmd();
                    applyToSelection();
                    curScore.endCmd();
                    quit();
                }
            }
        }
    }

    onRun: {
        if (typeof curScore === 'undefined')
            quit();
    }

    function findKeySignature() {
        var c = curScore.newCursor();
        // c.inputStateMode = Cursor.INPUT_STATE_SYNC_WITH_SCORE;
        var keySigOffset = c.keySignature;
        var prefix = "  Key Signature: ";
        if (isNaN(keySigOffset)) {
            return prefix + "unknown";
        }
        var offsetToClass = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5];
        var noteNames = ["C", "D♭", "D", "E♭", "E", "F", "F♯/G♭", "G", "A♭", "A", "B♭", "B"];
        var keyIndex = keySigOffset;
        if (keyIndex < 0)
            keyIndex += 12;
        var pitchClass = offsetToClass[keyIndex];
        var noteName = noteNames[pitchClass];
        if (keySigOffset == 6) {
            noteName = "F♯";
        } else if (keySigOffset == -6) {
            noteName = "G♭";
        }
        var keySigText = "";
        if (keySigOffset > 0) {
            keySigText = "♯".repeat(keySigOffset);
            keySigText += "/" + noteName;
        } else if (keySigOffset < 0) {
            keySigText = "♭".repeat(-keySigOffset);
            keySigText += "/" + noteName;
        } else {
            keySigText = "C";
        }
        return `${prefix}${keySigText} (${noteName}4=${pitchClass + 60})`;
    }

    function calcYOffset(part) {
        return 2 * part;
    }

    function formatText(text) {
        // text.subStyle = 50;  // User-3
        text.placement = Placement.BELOW;
        text.autoplace = false;
        text.align = Align.RIGHT + Align.BASELINE;
        text.fontFace = fontFamily;
        text.fontSize = inputFontSize.value;
        text.lineSpacing = inputLineSpacing.value; // no effect yet
        text.color = inputFontColor.text;
        text.offsetX = inputXOffset.value;
        text.offsetY = inputYOffset.value;
    }

    function applyToSelection() {
        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;
        var selPart = 0;
        cursor.rewind(1);  // rewind to start of selection
        if (!cursor.segment) {
            // no selection
            fullScore = true;
            startStaff = 0; // start with 1st staff
            endStaff = curScore.nstaves - 1; // and end with last
        } else {
            startStaff = cursor.staffIdx;
            cursor.rewind(2); // rewind to end of selection
            if (cursor.tick == 0) {
                endTick = curScore.lastSegment.tick + 1;
            } else {
                endTick = cursor.tick;
            }
            endStaff = cursor.staffIdx;
        }
        for (var staff = startStaff; staff <= endStaff; staff++) {
            var part = inputPart.key;
            cursor.rewind(1); // beginning of selection
            cursor.part = part;
            cursor.staffIdx = staff;
            if (fullScore)  // no selection
                cursor.rewind(0); // beginning of score

            while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                if (cursor.element && cursor.element.type == Element.CHORD) {
                    // If it is a note, not a rest
                    var text = newElement(Element.STAFF_TEXT);
                    var graceChords = cursor.element.graceNotes;
                    for (var i = 0; i < graceChords.length; i++) {
                        var notes = graceChords[i].notes;
                        writeNoteText(notes, text, inputNotationFormat.key);
                        formatText(text);
                        text.fontSize = inputFontSize.value * 0.7;
                        text.offsetX += -2.0 * (graceChords.length - i);      // X position of Grace note
                        text.offsetY += calcYOffset(part); // Fixed missing semicolon here
                        cursor.add(text);
                        text = newElement(Element.STAFF_TEXT);
                    } // end graceChords

                    var text = newElement(Element.STAFF_TEXT);
                    var notes = cursor.element.notes;
                    writeNoteText(notes, text, inputNotationFormat.key);
                    formatText(text);
                    text.offsetY += calcYOffset(part);
                    cursor.add(text); //   音符に表示
                }
                cursor.next();
            } // end while segment
        } // end for staff
    } // end function

    function writeNoteText(notes, text, notationFormat) {
        var formats = [];
        formats.push(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]);
        formats.push(["1", "#1", "2", "#2", "3", "4", "#4", "5", "#5", "6", "#6", "7"]);
        formats.push(["1", "b2", "2", "b3", "3", "4", "b5", "5", "b6", "6", "b7", "7"]);
        function getNoteText(pitchClass) {
            var noteText = formats[notationFormat][pitchClass];
            if (notationFormat != 0 && noteText.length > 1) {
                noteText = "<sup>" + noteText[0] + "</sup>" + noteText[1];
            }
            return noteText;
        }
        var dot = "•";
        var sep = "\n";
        for (var i = 0; i < notes.length; i++) {
            if (i > 0)
                text.text = sep + text.text; // multiple notes vertically
            if (notes[i].tieBack == null) {
                var relativeOctave = Math.floor((notes[i].pitch - inputReferenceNote.value) / 12);
                var pitchClass = (notes[i].pitch - inputReferenceNote.value) % 12;
                if (pitchClass < 0)
                    pitchClass += 12;
                var textBefore = "";
                if (relativeOctave > 0)
                    textBefore += "<sup>" + dot.repeat(relativeOctave) + "</sup>";
                if (relativeOctave < 0)
                    textBefore += "<sub>" + dot.repeat(-relativeOctave) + "</sub>";
                text.text = textBefore + getNoteText(pitchClass) + text.text;
            }// end for tieBack
        }
    } // end for note
} // end MuseScore
