global 1s := 1000

/*
Initialized inventory and cost
*/
global Glimmer_inv := 0
global Prism_inv := 0
global price := [1000, 2500, 3000]
global iteration := 0

/*
Initialized resolution arrays and switch
*/
global 1080r := [[,],[,],[,],[,],[,],[,],[,]]
global 2560r := [[1198, 525],[446, 1100], [2409, 765], [964, 1031],[534,556],[1858, 1021],[2003, 1016]] 
global resolutionSwitch :=  {1: 1080r,  2: 2560r }
global rSwitch
global cRes


InputBox, Glimmer_inv, Current Glimmer, Enter the exact glimmer amount you want to spend
InputBox, Prism_inv, Current Prisms, Enter the exact prisms amount you want to spend
InputBox, rSwitch, What Resolution, Enter 1 for 1080p and 2 for 2560p resolution

;Selecting the resolution
cRes := resolutionSwitch[rSwitch]

CoordMode, Mouse, Screen

F2::Reload
F3::StartApplication()
F4::ExitApp


StartApplication()
{
    /*
    The core loop will pick up 9 blue items 
    Then upgrade each individual item 
    Then dismantle it for cores
    */
    Loop
    {
    Send {i}
    Delay(1s)
    Send {a}
    Delay(1s)
    Send {a}
    Delay(1s)
    ClickMouse(cRes[1])
    Delay(1s)
    ClickMouse(cRes[2])
    Delay(1s)
    ClickMouse(cRes[3])
    Delay(1s)
    Loop, 9
    {
        CheckCurrency(Glimmer_inv, 777, "Glimmer")
        HoldLMouseB(cRes[4], 3100)
        Glimmer_inv := Glimmer_inv - 777
    }
    Delay(1s)
    ToInventory()
    Delay(1s)
    Loop, 9
    {
    HoverItem()
    Delay(500)
    Send, {RButton}
    Delay(1s)
    iteration := 1
        Loop, 3
        { 
        CheckCurrency(Glimmer_inv, price[iteration], "Glimmer")
        if(iteration == 3){
            CheckCurrency(Prism_inv, 1, "Prism")
            Prism_inv := Prism_inv - 1
        }     
        HoldLMouseB(cRes[5], 1s)
        Delay(1s)
        Glimmer_inv := Glimmer_inv - price[iteration]
        iteration := iteration + 1
        }   
    ToInventory()
    Delay(1s)
    HoverItem()
    Delay(1s)
    Dismantle()
    }
    Send {Esc}
    Delay(1s)
    }
}




; Making codde a little bit readable
ToInventory(){
    Send {i}
}

; Function to hold left mouse button, used for getting blues from collections and upgrade blues
HoldLMouseB(coordinates, delay){
    x := coordinates[1]
    y := coordinates[2]
    MouseMove, x , y
    Send {LButton Down}
    Sleep, delay
    Send {LButton Up}
}

; Function to click based on given coordinates 
ClickMouse(coordinates){
    x := coordinates[1]
    y := coordinates[2]
    Click, x, y
}

; Function to hold the button F down to dismantle blues
Dismantle(){
    Send {f Down}
    Delay(3000)
    Send {f Up}
}

; Function to hover the blues that are either going to be upgraded or dismantled
HoverItem(){
    MouseMove, cRes[6,1], cRes[6,2]
    Delay(1s)
    MouseMove, cRes[7,1], cRes[7,2]
}

; Function to check if it's user is out of resources
CheckCurrency(unitNeeded, unitUsed, sampleText){
If(unitNeeded < unitUsed){

    MsgBox, 0,, You have %Glimmer_inv% left of your desired glimmer usage`nYou have %Prism_inv% left of your desired prisms usage`nYou would need %unitUsed% %sampleText% to continue
    Reload
}
}

; Functions to generate delays
Delay(s){
    Sleep, s
}
