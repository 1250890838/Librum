import QtQuick
import QtQuick.Layouts
import QtQuick.Controls


FocusScope
{
    id: root
    property int bookCount : 10
    
    implicitWidth: 1714
    implicitHeight: 32
    
    
    RowLayout
    {
        id: layout
        property MContentRect current : contentRect1
        
        height: parent.height
        width: parent.width
        spacing: 0
        
        MBookCountSelector
        {
            id: bookCountSelector
        }
    
        Label
        {
            id: descriptionLabel
            Layout.alignment: Qt.AlignVCenter
            Layout.leftMargin: 8
            text: "Entries per page"
            color: properties.colorLightText
            font.pointSize: 11
            font.family: properties.defaultFontFamily            
        }
        
        Item { Layout.fillWidth: true }
        
        Item
        {
            id: indexer
            Layout.preferredWidth: 230
            Layout.preferredHeight: 32
            
            RowLayout
            {
                id: indexerLayout
                height: parent.height
                spacing: 0
                
                MNavigationArrow
                {
                    id: leftNavigationArrow
                    toLeft: true
                    
                    onClicked: layout.moveToLeft();
                }
                
                MContentRect
                {
                    id: contentRect1
                    pageNumber: 1
                    selected: true
                    
                    onClicked: layout.changeSelected(this)
                }
                
                MContentRect
                {
                    id: contentRect2
                    pageNumber: 2
                    
                    onClicked: layout.changeSelected(this)
                }
                
                MContentRect
                {
                    id: contentRect3
                    pageNumber: 3
                    
                    onClicked: layout.changeSelected(this)
                }
                
                Rectangle
                {
                    id: dotRect
                    Layout.preferredWidth: 36
                    Layout.preferredHeight: 36
                    color: "transparent"
                    border.color: "transparent"               
                    radius: 5
                    
                    Label
                    {
                        anchors.centerIn: parent
                        text: "..."
                        font.pointSize: 14
                        font.family: properties.defaultFontFamily
                        font.bold: false
                        color: properties.colorBaseText
                    }
                }
                
                MContentRect
                {
                    id: contentRect4
                    pageNumber: 10
                    
                    onClicked: layout.changeSelected(this)
                }
                
                MNavigationArrow
                {
                    id: rightNavigationArrow
                    
                    onClicked: layout.moveToRight();
                }
            }
        }
        
        
        function changeSelected(newItem)
        {
            if(newItem === layout.current)
                return;
            
            layout.current.selected = false;
            layout.current = newItem;
            layout.current.selected = true
        }
        
        function moveToLeft()
        {
            switch(layout.current)
            {
            case contentRect1:
                break;
            case contentRect2:
                changeSelected(contentRect1);
                break;
            case contentRect3:
                changeSelected(contentRect2);
                break;
            case contentRect4:
                changeSelected(contentRect3);
                break;
            }
        }
        
        function moveToRight()
        {
            switch(layout.current)
            {
            case contentRect1:
                changeSelected(contentRect2);
                break;
            case contentRect2:
                changeSelected(contentRect3);
                break;
            case contentRect3:
                changeSelected(contentRect4);
                break;
            case contentRect4:
                break;
            }
        }
    }
}