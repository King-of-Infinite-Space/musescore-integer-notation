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
    menuPath: "Plugins." + qsTr("Integer Notation Inside")
    version: "0.4.1"
    description: qsTr("Replace noteheads with Integer Notation or Numbered Notation")
    pluginType: "dialog"
    width: 320  // menu window size
    height: 540

    Component.onCompleted: {
        if (mscoreMajorVersion >= 4) {
            title = qsTr("Integer Notation Inside");
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
                id: inputNotationFormat
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    ListElement {
                        text: "0~11"
                    }
                    ListElement {
                        text: "1~7,♭"
                    }
                    ListElement {
                        text: "1~7,♯"
                    }
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
                text: "Reference note signature"
                Layout.fillWidth: true
            }
            ComboBox {
                id: inputRefSigFormat
                Layout.alignment: Qt.AlignRight
                Layout.preferredWidth: 100
                currentIndex: 0
                model: ListModel {
                    ListElement {
                        text: "1st degree (0=X / 1=X)"
                    }
                    ListElement {
                        text: "6th degree (9=X / 6=X)"
                    }
                    ListElement {
                        text: "None"
                    }
                }
            }
        }
        RowLayout {
            Label {
                text: "Show octave dots (like Jianpu)"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputOctaveDots
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Set stem direction up"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputStemUp
                text: ""
                checked: true
                Layout.alignment: Qt.AlignRight
            }
        }
        RowLayout {
            Label {
                text: "Re-position notes vertically"
                Layout.fillWidth: true
            }
            CheckBox {
                id: inputReposition
                text: ""
                checked: false
                Layout.alignment: Qt.AlignRight
            }
        }
        Rectangle {
            width: parent.width
            height: 2
            color: "transparent"
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#cccccc"
        }
        Rectangle {
            width: parent.width
            height: 2
            color: "transparent"
        }

        RowLayout {
            Label {
                text: "Text size"
                Layout.fillWidth: true
            }
            SpinBox {
                id: inputFontSize
                implicitWidth: 55
                decimals: 1
                minimumValue: 5
                maximumValue: 15
                value: 9.5
                stepSize: 0.5
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Text color (RGB value)"
                Layout.fillWidth: true
            }
            TextField {
                id: inputTextColor
                text: "#000000"
                Layout.preferredWidth: 60
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
                text: "Method to hide notehead"
                Layout.fillWidth: true
            }
            ComboBox {
                currentIndex: 0
                id: inputHideMethod
                model: ListModel {
                    property var key
                    ListElement {
                        text: "color"
                    }
                    ListElement {
                        text: "visibility"
                    }
                }
                Layout.preferredWidth: 100
                Layout.alignment: Qt.AlignRight
            }
        }

        RowLayout {
            Label {
                text: "Notehead color (RGB value)"
                Layout.fillWidth: true
            }
            TextField {
                id: inputColor
                text: "#f9f9f9"
                Layout.preferredWidth: 60
                Layout.alignment: Qt.AlignRight
                enabled: (inputHideMethod.currentText == "color")
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
                        text: "Custom-11"
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
                    main();
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

    function pcToNoteName(pc, format) {
        var noteNamesFormats = {
            "flat": ["C", "D♭", "D", "E♭", "E", "F", "G♭", "G", "A♭", "A", "B♭", "B"],
            "sharp": ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "A♯", "B"],
            "minor": ["C", "C♯", "D", "D♯", "E", "F", "F♯", "G", "G♯", "A", "B♭", "B"]
        }
        return noteNamesFormats[format][pc];
    }

    function findKeySignature() {
        var c = curScore.newCursor();
        // c.inputStateMode = Cursor.INPUT_STATE_SYNC_WITH_SCORE;
        var keySigOffset = c.keySignature;
        var prefix = "Initial key ";
        if (isNaN(keySigOffset)) {
            return prefix + "unknown";
        }
        var offsetToClass = [0, 7, 2, 9, 4, 11, 6, 1, 8, 3, 10, 5];
        
        var keyIndex = keySigOffset;
        if (keyIndex < 0)
            keyIndex += 12;
        var pitchClass = offsetToClass[keyIndex];
        var noteName = pcToNoteName(pitchClass, "flat");
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
        if (refNote >= 67) {
            refNote -= 12;
        }
        var oct = refNote >= 60 ? 4 : 3;
        inputReferenceNote.value = refNote;
        return `(${prefix}${keySigText}, ${noteName}${oct}=${refNote})`;
    }

    function formatText(textEl, isGrace) {
        if (inputStyle.key == -1) {
            // 60 = User-12
            textEl.subStyle = 59
            textEl.autoplace = false;
            // automatically place the text to prevent overlapping with other elements
            textEl.align = Align.RIGHT + Align.VCENTER;
            // text alignment horizontally and vertically
            textEl.fontFace = fontFamily;
            textEl.fontSize = inputFontSize.value
            textEl.color = inputTextColor.text
            textEl.offsetX = inputXOffset.value
            textEl.offsetY = 0
            if (inputReposition.checked) {
                textEl.align = Align.RIGHT + Align.BASELINE;
                textEl.offsetY = 0.5
            }
        } else {
            textEl.subStyle = inputStyle.key;
        }
        if (isGrace) {
            textEl.fontSize = 7
        }
    }

    function rgbToHex(rgb) {
        // Convert each component to hexadecimal and concatenate them
        return "#" + ((1 << 24) + (rgb[0] << 16) + (rgb[1] << 8) + rgb[2]).toString(16).slice(1);
    }

    function main() {
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
        let refNoteSig;
        for (let staff = startStaff; staff <= endStaff; staff++) {
            for (let voice = 0; voice < 4; voice++) {
                cursor.rewind(1);
                cursor.voice = voice;
                cursor.staffIdx = staff;
                if (fullScore)  // no selection
                    cursor.rewind(0); // beginning of score

                while (cursor.segment && (fullScore || cursor.tick < endTick)) {
                    if (cursor.element
                    && (cursor.element.type == Element.CHORD
                    || cursor.element.type == Element.REST)) {
                        if (inputRefSigFormat.currentIndex != 2 && !refNoteSig) {
                            refNoteSig = createRefNoteSig();
                            cursor.add(refNoteSig);
                        }
                    }
                    if (cursor.element && cursor.element.type == Element.CHORD) {
                        //     let staff = cursor.element.staff
                        //     staff.staffLines = 1
                        //     staff.lineDistance = 1.25
                        //     staffModified = true
                        // staff properties not exposed as api
                        // see https://musescore.org/en/node/310685
                        
                        let graceChords = cursor.element.graceNotes
                        for (var i = 0; i < graceChords.length; i++) {
                            transformNotes(graceChords[i].notes, true)
                        }
                        transformNotes(cursor.element.notes, false)
                    }
                    cursor.next();
                } // end while
            } // end for voice
        } // end for staff
    } // end function

    function transformNotes(notes, isGrace) {
        // const invisibleColor = rgbToHex([240,240,240]) // f0f0f0
        // const invisibleColor = "#f3f3f3"
        // const invisibleColor = "#f9f9f9" // 249, page background color
        const invisibleColor = inputColor.text
        for (let i = 0; i < notes.length; i++) {
            let note = notes[i]
            let textEl = createTextElement(note);
            formatText(textEl, isGrace);
            if (note.durationType.type == 3) {
                // half note
                // textEl.frameType = 2 // circle
                // textEl.framePadding = 0.1
                textEl.fontStyle = 2 // italic
            }
            note.add(textEl);
            if (inputHideMethod.currentText == "color") {
                note.color = invisibleColor
                // note.headGroup = 18 // rectangle
                note.headGroup = 20 // rhombus
            }
            if (inputHideMethod.currentText == "visibility") {
                note.visible = false
                // if hide notehead, some numbers will collapse together
                // (notes on adjacent staff line and space)
            }
            // note.small = true
            // note.noStem = true

            if (note.accidental) {
                if (inputHideMethod.currentText == "color") {
                    note.accidental.color = invisibleColor
                    note.accidental.small = true
                }
                if (inputHideMethod.currentText == "visibility") {
                    note.accidental.visible = false
                }
            }
            if (inputReposition.checked) {
                note.fixed = true
                note.fixedLine = 1 + 3*(notes.length - 1 - i)
                // i=0 is lowest note, line 1 is top space
            }
            if (inputStemUp.checked) {
                note.stemDirection = 1
                // stem up (to the right of notes)
                // prevent occlusion of octave dots (to the left of notes)
            }
        }
    }

    function getNoteText(pitchClass) {
        let formats = [];
        formats.push(["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]);
        formats.push(["1", "b2", "2", "b3", "3", "4", "b5", "5", "b6", "6", "b7", "7"]);
        formats.push(["1", "#1", "2", "#2", "3", "4", "#4", "5", "#5", "6", "#6", "7"]);
        let notation = formats[inputNotationFormat.currentIndex]
        var noteText = notation[pitchClass]
        if ("#b".includes(noteText[0])) {
            noteText = "<sup>" + noteText[0] + "</sup>" + noteText[1];
        }
        return noteText;
    }

    function createRefNoteSig() {
        let el = newElement(Element.STAFF_TEXT)
        let text = ""
        if (inputRefSigFormat.currentIndex == 0)  {
            text += inputNotationFormat.currentIndex == 0 ? "0=" : "1="
            text += pcToNoteName(inputReferenceNote.value % 12, "flat")
        } else if (inputRefSigFormat.currentIndex == 1) {
            text += inputNotationFormat.currentIndex == 0 ? "9=" : "6="
            text += pcToNoteName((inputReferenceNote.value + 9) % 12, "minor")
        }
        if (inputOctaveDots.checked) {
            let refNote = inputReferenceNote.value
            if (inputRefSigFormat.currentIndex == 1)
                refNote += 9
            let octave = Math.floor(refNote / 12) - 1;
            text += octave
        }
        el.text = text
        return el;
    }

    function createTextElement(note) {
        let el = newElement(Element.FINGERING)

        let relPitchClass = (note.pitch - inputReferenceNote.value + 1200) % 12;
        let relativeOctave = Math.floor((note.pitch - inputReferenceNote.value) / 12);
        let dot = "•";
        let text = "";
        if (relativeOctave > 0 && inputOctaveDots.checked)
            text += "<sup>" + dot.repeat(relativeOctave) + "</sup>";
        if (relativeOctave < 0 && inputOctaveDots.checked)
            text += "<sub>" + dot.repeat(-relativeOctave) + "</sub>";
        text += getNoteText(relPitchClass)
        el.text = text
        return el;
    } // end for note
} // end MuseScore
