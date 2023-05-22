page 50204 "Luxury Item Rental Subpage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Luxury Item Rental Unit";

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
            }
        }
        // area(Factboxes)
        // {

        // }
    }

    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {
        //         ApplicationArea = All;

        //         trigger OnAction();
        //         begin

        //         end;
        //     }
        // }
    }
}