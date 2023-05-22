codeunit 50213 "Rental-Post (Yes/No)"
{
    TableNo = "Luxury Item Rental Order";

    trigger OnRun()
    begin
        LuxuryItemRentalOrder.Copy(Rec);
        Code();
        Rec := LuxuryItemRentalOrder;
    end;

    var
        LuxuryItemRentalOrder: Record "Luxury Item Rental Order";
        Text000: Label 'Do you want to post the %1?';
        Text003: Label 'The order was successfully posted.';

    local procedure "Code"()
    begin

        if not Confirm(Text000, false, LuxuryItemRentalOrder."No.") then
            exit;

        CODEUNIT.Run(CODEUNIT::"Rental-Post", LuxuryItemRentalOrder);

        Message(Text003);
    end;

}

