page 50235 "Most Rented Items"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Luxury Item";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    Caption = 'Item No.';
                }
                field("Description"; Rec.Description)
                {
                    Caption = 'Item Description';
                }
                field(RentalCount; Rec.RentalCount)
                {
                    Caption = 'Rental Count';

                }
            }
        }
        area(Factboxes)
        {
        }
    }
}
