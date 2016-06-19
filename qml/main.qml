import QtQuick 2.4
import Material 0.3
import QuickFlux 1.0

import "."
import "Pages"
import "QuickFlux/Actions"

ApplicationWindow {
    id: bdiskWindow

    title: qsTr("BNetDisk")
    visible: true

    theme {
        primaryColor: "blue"
        accentColor: "red"
        tabHighlightColor: "white"
    }

    iconHelper {
        useQtResource: false
        /**************************
        if set useQtResource to true, alternativePath should be the prefix value in qrc
        if set useQtResource to false
            if using material system-wide icons, alternativePath should be setted to empty, Eg. ""
            if using application alternative icons, alternativePath should be setted to full path of icon path
        ***************************/
        alternativePath: ""
    }

    Loader {
        id: progressLoader
        anchors.centerIn: parent
        sourceComponent: progressComponent
    }
    Component {
        id: progressComponent
        ProgressCircle {
            id: progressCircle
            anchors.centerIn: parent
            z: 10
            indeterminate: true
            width: dp(64)
            height: width
            dashThickness: dp(8)
        }
    }
    AppScript {
        runWhen: ActionTypes.showProgress
        script: {
            progressLoader.sourceComponent = progressComponent;
        }
    }
    AppScript {
        runWhen: ActionTypes.hideProgress
        script: {
            progressLoader.sourceComponent = progressLoader.Null;
        }
    }

    initialPage: MainViewPage {
        Component.onCompleted: {
            console.log("===== MainViewPage onCompleted")
            AppActions.showRootDir();
        }
    }
}
