CREATE OR REPLACE TYPE tipoStockItem AS OBJECT(
    StockNo NUMBER,
    Price NUMBER,
    TaxRate NUMBER
);

CREATE OR REPLACE TYPE tipoLineItem AS OBJECT(
    LineItemNo NUMBER,
    Quantity NUMBER,
    Discount NUMBER,
    StockItemRef REF tipoStockItem
);

CREATE OR REPLACE TYPE tipoPhone AS OBJECT(
    PhoneNumber VARCHAR2(11)
);

CREATE OR REPLACE TYPE tipoListPhone AS ARRAY(10) OF tipoPhone; 

CREATE OR REPLACE TYPE tipoAddress AS OBJECT(
    Street VARCHAR2(256),
    City VARCHAR2(256),
    State CHAR(2),
    Zip VARCHAR2(32)
);

CREATE OR REPLACE TYPE tipoCustomer AS OBJECT(
    CustNo NUMBER,
    CustName VARCHAR2(64),
    ListPhone tipoListPhone,
    Address tipoAddress
);

CREATE OR REPLACE TYPE tipoListLineItem AS TABLE OF tipoLineItem;

CREATE OR REPLACE TYPE tipoPurchaseOrder AS OBJECT(
    PONo NUMBER,
    OrderDate DATE,
    ShipDate DATE,
    ListLineItem tipoListLineItem,
    CustomerRef REF tipoCustomer,
    Address tipoAddress,

    MEMBER FUNCTION getPONo RETURN NUMBER,
    MEMBER FUNCTION sumLineItems RETURN NUMBER
);

CREATE OR REPLACE TYPE BODY tipoPurchaseOrder AS
    MEMBER FUNCTION getPONo RETURN NUMBER IS
        BEGIN
            RETURN SELF.PONo;
        END;
    MEMBER FUNCTION sumLineItems RETURN NUMBER IS
        totalPrice NUMBER;
        indice NUMBER;
        BEGIN
            FOR indice IN 1 .. ListLineItem.count LOOP
                totalPrice := totalPrice + ListLineItem(indice).Quantity*ListLineItem(indice).StockItemRef.Price;
            END LOOP;
            RETURN totalPrice;
        END;
END;


CREATE TABLE PurchaseOrder OF tipoPurchaseOrder()NESTED TABLE ListLineItem STORE AS ListaItem;

