Page 50203 "Luxury Clothing Classes"

{
PageType = List;
ApplicationArea = all;
UsageCategory = Administration;
SourceTable = "Luxury Clothing Class";
Caption = 'Luxury Item Classes';

layout
{
    area(content)
    {
        repeater(Control1)
        {
            ShowCaption = false;
            field("Code"; Rec.Code)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies a code for the class that the luxury clothing item belongs to.';
            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the luxury clothing item class.';
            }
            field("Default Renting Location Code"; Rec."Default Renting Location Code")
            {
                ApplicationArea = All;
            }
        }
    }
}

var
    // myInt: Integer;

trigger OnOpenPage()
begin
    Rec.Reset();
    if not Rec.Get() then begin
        Rec.Init();
        Rec.Insert();
    end;
end;
}