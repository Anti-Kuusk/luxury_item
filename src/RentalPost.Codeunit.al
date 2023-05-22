codeunit 50212 "Rental-Post"
{

    TableNo = "Luxury Item Rental Order";

    trigger OnRun()
    var
        LuxuryItemRentalOrder: Record "Luxury Item Rental Order";
    begin
        ClearAll();
        LuxuryItemRentalOrder := Rec;

        InitPost(LuxuryItemRentalOrder);
        Post(LuxuryItemRentalOrder, RentalJnlPostLine);
        FinalizePost(LuxuryItemRentalOrder);

        Rec := LuxuryItemRentalOrder;
    end;

    var

        RentalJnlPostLine: Codeunit "Rental Jnl.-Post Line";
        PostingDate: Date;

    local procedure InitPost(var RentalOrder: Record "Luxury Item Rental Order")
    begin
        RentalOrder.TestField("No.");
        RentalOrder.TestField("Customer No.");
        RentalOrder.TestField("Rental Item No.");
        RentalOrder.TestField("Rental Item Unit No.");
        RentalOrder.TestField("Rental Start");
        RentalOrder.TestField("Rental End");
        RentalOrder.TestField("Rental Days");

        PostingDate := WorkDate();


    end;

    local procedure Post(var RentalOrder: Record "Luxury Item Rental Order"; var RentalJnlPostLine: Codeunit "Rental Jnl.-Post Line")
    var

        RentalJnlLine: Record "Rental Journal Line" temporary;
    begin
        RentalJnlLine.Init();
        RentalJnlLine."Document No." := RentalOrder."No.";
        RentalJnlLine."Posting Date" := PostingDate;
        RentalJnlLine."Rental Order No." := RentalOrder."No.";
        RentalJnlLine."Customer No." := RentalOrder."Customer No.";
        RentalJnlLine."Luxury Rental Item No." := RentalOrder."Rental Item No.";
        RentalJnlLine."Luxury Item Rental Unit No." := RentalOrder."Rental Item Unit No.";

        RentalJnlLine."Rental Start" := RentalOrder."Rental Start";
        RentalJnlLine."Rental End" := RentalOrder."Rental End";
        RentalJnlLine."Rental Days" := RentalOrder."Rental Days";


        RentalJnlPostLine.RunCheck(RentalJnlLine);

    end;

    local procedure FinalizePost(Rentalorder: Record "Luxury Item Rental Order")
    begin
        //ToDo Change Rental Order Status

    end;


}