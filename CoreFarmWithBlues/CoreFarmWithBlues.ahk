global 1s := 1100
global Glimmer_inv := 0
global Prism_inv := 0
global price := [1000, 2500, 3000]
global iteration := 0


InputBox,  Glimmer_inv, Current Glimmer, Enter the exact glimmer amount you want to spend
InputBox, Prism_inv, Current Prisms, Enter the exact prisms amount you want to spend

CoordMode, Mouse, Screen

F2::Reload
F3::StartApplication()
F4::ExitApp


StartApplication()
{
    Loop
    {
    Send {i}
    Delay(1s)
    Send {a}
    Delay(1s)
    Send {a}
    Delay(1s)
    Click, 1198, 525
    Delay(1s)
    Click, 446, 1100
    Delay(1s)
    Click, 2409, 765
    Delay(1s)
    Loop, 9
    {
        CheckCurrency(Glimmer_inv, 777, "Glimmer")
        MouseCmd(964, 1031, 3100)
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
        MouseCmd(534,556, 1s)
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
    MoveChar()
    Delay(1s)
    }
}





ToInventory()
{
    Send {i}
}

MoveChar()
{
    loop, 5
    {
    Send {a}
    Send {d}
    }
}

MouseCmd(x,y,delay)
{
    MouseMove, x , y
    Send {LButton Down}
    Sleep, delay
    Send {LButton Up}
}

Dismantle()
{
    Send {f Down}
    Delay(3000)
    Send {f Up}
}

HoverItem()
{
    MouseMove, 1858, 1021
    Delay(1s)
    MouseMove, 2003, 1016
}

CheckCurrency(unitNeeded, unitUsed, sampleText)
{
 
If(unitNeeded < unitUsed){

    MsgBox, 0,, You have %Glimmer_inv%  glimmer left`nYou have %Prism_inv% prisms left`nYou would need %unitUsed% %sampleText% to continue
    Reload
}
}

Delay(s)
{
    Sleep, s
}
