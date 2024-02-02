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
    version: "0.3.0"
    description: qsTr("Add Integer Notation or Numbered Notation of the notes below the staves")
    pluginType: "dialog"
    width: 300  // menu window size
    height: 540

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
                text: "Voice"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                model: ListModel {
                    id: inputVoice
                    property var key
                    ListElement {
                        text: "All"
                        pName: -1
                    }
                    ListElement {
                        text: "Voice 1"
                        pName: 0
                    }
                    ListElement {
                        text: "Voice 2"
                        pName: 1
                    }
                    ListElement {
                        text: "Voice 3"
                        pName: 2
                    }
                    ListElement {
                        text: "Voice 4"
                        pName: 3
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
                onCurrentIndexChanged: {
                    inputVoice.key = inputVoice.get(currentIndex).pName;
                }
            }
        }

        RowLayout {
            Label {
                text: "Text style"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                model: ListModel {
                    id: inputStyle
                    property var key
                    ListElement {
                        text: "Custom"
                        pName: -1
                    }
                    ListElement {
                        text: "User-1"
                        pName: 49
                    }
                    ListElement {
                        text: "User-2"
                        pName: 50
                    }
                    ListElement {
                        text: "User-3"
                        pName: 51
                    }
                    ListElement {
                        text: "User-4"
                        pName: 52
                    }
                    ListElement {
                        text: "User-5"
                        pName: 53
                    }
                    ListElement {
                        text: "User-6"
                        pName: 54
                    }
                    ListElement {
                        text: "User-7"
                        pName: 55
                    }
                    ListElement {
                        text: "User-8"
                        pName: 56
                    }
                    ListElement {
                        text: "User-9"
                        pName: 57
                    }
                    ListElement {
                        text: "User-10"
                        pName: 58
                    }
                    ListElement {
                        text: "User-11"
                        pName: 59
                    }
                    ListElement {
                        text: "User-12"
                        pName: 60
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
                onCurrentIndexChanged: {
                    inputStyle.key = inputStyle.get(currentIndex).pName;
                }
            }
        }

        RowLayout {
            Label {
                text: "Placement"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                model: ListModel {
                    id: inputPlacement
                    property var key
                    ListElement {
                        text: "Above"
                        pName: "above"
                    }
                    ListElement {
                        text: "Below"
                        pName: "below"
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
                onCurrentIndexChanged: {
                    inputPlacement.key = inputPlacement.get(currentIndex).pName;
                }
                enabled: (inputStyle.key == -1)
            }
        }
        RowLayout {
            Label {
                text: "Auto placement (prevent overlap)"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputAutoPlacement
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
                enabled: (inputStyle.key == -1)
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
                enabled: (inputStyle.key == -1)
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
                enabled: (inputStyle.key == -1)
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
                enabled: (inputStyle.key == -1)
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
                value: 0
                Layout.alignment: Qt.AlignRight
                enabled: (inputStyle.key == -1)
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
                enabled: (inputStyle.key == -1)
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
        var refNote = pitchClass + 60;
        inputReferenceNote.value = refNote;
        return `${prefix}${keySigText} (${noteName}4=${refNote})`;
    }

    function formatText(text) {
        if (inputStyle.key == -1) {
            // 56 = User-8
            // 60 = User-12
            text.subStyle = 60

            text.placement = inputPlacement.key == "above" ? Placement.ABOVE : Placement.BELOW;
            // above or below the staff
            text.autoplace = inputAutoPlacement.checked ? true : false;
            // automatically place the text to prevent overlapping with other elements
            text.align = Align.RIGHT + Align.BASELINE;
            // text alignment horizontally and vertically
            text.fontFace = fontFamily;
            text.fontSize = inputFontSize.value;
            text.textLineSpacing = inputLineSpacing.value;
            // no effect, lineSpacing seems not exposed to plugin API yet
            // https://github.com/musescore/MuseScore/blob/ed678925efbbdbb9bd14ea3f6f7c9b5ab42491e7/src/plugins/api/elements.h#L348
            text.color = inputFontColor.text;
            text.offsetX = inputXOffset.value;
            text.offsetY = inputYOffset.value;
        } else {
            text.subStyle = inputStyle.key;
        }
    }

    function applyToSelection() {
        var cursor = curScore.newCursor();
        var startStaff;
        var endStaff;
        var endTick;
        var fullScore = false;

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
        for (let staff = startStaff; staff <= endStaff; staff++) {
            for (let voice = 0; voice < 4; voice++) {
                if (inputVoice.key != -1 && inputVoice.key != voice)
                    continue;
                cursor.rewind(1); // beginning of selection
                cursor.voice = voice;
                cursor.staffIdx = staff;
                if (fullScore)  // no selection
                    cursor.rewind(0); // beginning of score

                while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                    if (cursor.element && cursor.element.type == Element.CHORD) {
                        // If it is a note, not a rest
                        let graceNotes = cursor.element.graceNotes;
                        for (let i = 0; i < graceNotes.length; i++) {
                            let notes = graceNotes[i].notes;
                            let text = createNoteText(notes, inputNotationFormat.key);
                            formatText(text);
                            text.fontSize = inputFontSize.value * 0.7;
                            text.offsetX += -1.5 * (graceNotes.length - i);      // X position of Grace note
                            cursor.add(text);
                        } // end graceNotes

                        let notes = cursor.element.notes;
                        let text = createNoteText(notes, inputNotationFormat.key);
                        formatText(text);
                        cursor.add(text); //   音符に表示
                    }
                    cursor.next();
                } // end while
            } // end for voice
        } // end for staff
    } // end function

    function createNoteText(notes, notationFormat) {
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
        let text = newElement(Element.STAFF_TEXT)
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
        return text;
    } // end for note
} // end MuseScore
