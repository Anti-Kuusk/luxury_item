page 50202 "Item Locations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Location";
    Caption = 'Item Locations';



    layout
    {
        area(Content)
        {
            repeater(ItemLocations)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a location code for the item.';
                }
                field("Rental Item Location Nos"; Rec."Rental Item Location Nos")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item location.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the address of the item location.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the City of the item location.';
                }
            }
        }

        // }
        // actions
        // {
        //     area(Processing)
        //     {
        //         action(Edit)
        //         {
        //             ApplicationArea = All;
        //             Caption = 'Edit';
        //             Promoted = true;
        //         }

        //         action(Save) { ApplicationArea = All; Caption = 'Save'; Promoted = true; }
        //         action(Cancel)
        //         {
        //             ApplicationArea = All;
        //             Caption = 'Cancel';
        //             Promoted = true;


        //         }
        //     }
    }

    var
    //myInt: Integer;

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
