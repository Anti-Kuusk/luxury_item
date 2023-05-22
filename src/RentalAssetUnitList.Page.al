page 50222 "Luxury Item Rental Unit List"
{
    Caption = 'Luxury Item Rental Unit List';
    PageType = List;
    SourceTable = "Luxury Item Rental Unit";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field("Luxury Item No."; Rec."Luxury Item No.")
                {

                }
                field("LI Unit No."; Rec."LI Unit No.")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("LI Location Code"; Rec."LI Location Code")
                {

                }
                field(Blocked; Rec.Blocked)
                {

                }
                field("Serial No."; Rec."Serial No.")
                {

                }

            }

        }
        area(Factboxes)
        {

        }
    }

}

