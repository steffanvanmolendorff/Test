/****************************************/
/* Example of using JSON libname engine */
/* for discovery, then with a JSON map  */
/* Copyright 2016 SAS Institute         */
/* written by Chris Hemedinger          */
/* http://blogs.sas.com/sasdummy        */
/****************************************/

/* split URL for readability */
/*
%let url1=http://communities.sas.com/kntur85557/restapi/vc/categories/id/bi/topics/recent;
%let url2=?restapi.response_format=json%str(&)restapi.response_style=-types,-null,view;
%let url3=%str(&)page_size=100;
%let fullurl=&url1.&url2.&url3;
*/
%let fullurl=http://localhost/sasweb/data/temp/json/atm.json;

filename topics temp;

proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;

/* Let the JSON engine do its thing */
libname posts JSON fileref=topics;
title "Automap of JSON data";

/* examine resulting tables/structure */
proc datasets lib=posts; quit;
proc print data=posts.alldata(obs=20); run;

/* Now create an automatic map to examine */
filename topics temp;
filename jmap "%sysfunc(GETOPTION(WORK))/top.map";

proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;

libname posts JSON fileref=topics map=jmap automap=create;
title "Using automatic JSON map";
proc datasets lib=posts; quit;

/* Finally, substitute in a custom map  */
filename topics temp;
filename minmap "%sysfunc(GETOPTION(WORK))/minmap.map";

data _null_ Work.X;
infile datalines;
file minmap;
input;
put _infile_;
datalines;
{
  "title": "ATM",
  "type": "object",
  "properties": {
    "Brand": {
      "description": "Brand of the Acquirer of transactions captured by the ATM",
      "type": "array",
      "uniqueItems": true,
      "minItems": 1,
      "items": {
        "title": "Brand",
        "description": "Brand",
        "type": "object",
        "properties": {
          "BrandName": {
            "description": "Brand of the Acquirer of transactions captured by the ATM",
            "type": "string",
            "minLength": 1,
            "maxLength": 140
          },
          "ATM": {
            "type": "array",
            "description": "ATM information.",
            "uniqueItems": true,
            "items": {
              "title": "ATM",
              "type": "object",
              "properties": {
                "Identification": {
                  "description": "ATM terminal device identification for the acquirer and the issuer.",
                  "type": "string",
                  "minLength": 1,
                  "maxLength": 35
                },
                "ATMServices": {
                  "description": "Describes the type of transaction available for a customer on an ATM.",
                  "type": "array",
                  "items": {
                    "description": "Information about ATM services",
                    "type": "string",
                    "enum": ["Balance", "BillPayments", "CashDeposits", "CharityDonation", "ChequeDeposits", "CashWithdrawal", "EnvelopeDeposit", "FastCash", "MobileBankingRegistration", "MobilePaymentRegistration", "MobilePhoneTopUp", "OrderStatement", "Other", "PINActivation", "PINChange", "PINUnblock", "MiniStatement"]
                  }
                },
                "SupportedLanguages": {
                  "description": "Identification of the language name according to the ISO 639-1 codes. The type is validated by the list of values coded with two alphabetic characters, defined in the standard.",
                  "type": "array",
                  "items": {
                    "description": "Identification of the language name according to the ISO 639-1 codes. The type is validated by the list of values coded with two alphabetic characters, defined in the standard.",
                    "type": "string",
                    "pattern": "[a-z]{2}"
                  }
                },
                "Accessibility": {
                  "description": "Indicates Types of Accessibility",
                  "type": "array",
                  "items": {
                    "description": "Indicates Types of Accessibility",
                    "type": "string",
                    "enum": ["AudioCashMachine", "AutomaticDoors", "ExternalRamp", "InductionLoop", "InternalRamp", "LevelAccess", "LowerLevelCounter", "Other", "WheelchairAccess"]
                  }
                },
                "Access24HoursIndicator": {
                  "description": "Indicates that the ATM is available for use by customers 24 hours per day",
                  "type": "boolean"
                },
                "SupportedCurrency": {
                  "description": "All ISO 4217 defined currency  supported by the ATM",
                  "type": "string",
                  "pattern": "[A-Z]{3}"
                },
                "MinimumPossibleAmount": {
                  "description": "Minimum amount allowed for a transaction in the service.",
                  "type": "string",
                  "pattern": "[0-9]{0,13}(\\.?[0-9]{0,5})?"
                },
                "Note": {
                  "description": "Summary description of the ATM.",
                  "type": "string",
                  "minLength": 1,
                  "maxLength": 2000
                },
                "OtherAccessibility": {
                  "description": "Enter a new code, name, and description for any other ATM accessibility options",
                  "type": "array",
                  "uniqueItems": true,
                  "items": {
                    "description": "Other Code Type",
                    "type": "object",
                    "properties": {
                      "Description": {
                        "description": "Description to describe the purpose of the code",
                        "type": "string",
                        "minLength": 1,
                        "maxLength": 350
                      },
                      "Name": {
                        "description": "Long name associated with the code",
                        "type": "string",
                        "minLength": 1,
                        "maxLength": 70
                      },
                      "Code": {
                        "description": "The four letter Mnemonic used within an XML file to identify a code",
                        "type": "string",
                        "pattern": "[A-Z]{4}"
                      }
                    },
                    "required": ["Name", "Code"],
                    "additionalProperties": false
                  }
                },
                "OtherATMServices": {
                  "description": "Enter a new code, name, and description for any other ATM accessibility options",
                  "type": "array",
                  "uniqueItems": true,
                  "items": {
                    "description": "Other Code Type",
                    "type": "object",
                    "properties": {
                      "Description": {
                        "description": "Description to describe the purpose of the code",
                        "type": "string",
                        "minLength": 1,
                        "maxLength": 350
                      },
                      "Name": {
                        "description": "Long name associated with the code",
                        "type": "string",
                        "minLength": 1,
                        "maxLength": 70
                      },
                      "Code": {
                        "description": "The four letter Mnemonic used within an XML file to identify a code",
                        "type": "string",
                        "pattern": "[A-Z]{4}"
                      }
                    },
                    "required": ["Name", "Code"],
                    "additionalProperties": false
                  }
                },
                "Branch": {
                  "description": "Information that locates and identifies a specific branch of a financial institution.",
                  "type": "object",
                  "properties": {
                    "BranchData": {
                      "description": "Unique and unambiguous identification of a branch of a financial institution.",
                      "type": "string",
                      "minLength": 1,
                      "maxLength": 35
                    }
                  },
                  "additionalProperties": false
                },
                "location": {
                  "description": "Information that locates and identifies a specific branch of a financial institution.",
                  "type": "object",
                  "properties": {
                    "LocationCategory": {
                      "description": "Indicates the environment of the ATM.",
                      "type": "string",
                      "enum": ["BranchExternal", "BranchInternal", "BranchLobby", "Other", "RetailerOutlet", "RemoteUnit"]
                    },
                    "OtherLocationCategory": {
                      "description": "Enter a new code, name, and description for any other location category",
                      "type": "array",
                      "items": {
                        "description": "Other Code Type",
                        "type": "object",
                        "properties": {
                          "Description": {
                            "description": "Description to describe the purpose of the code",
                            "type": "string",
                            "minLength": 1,
                            "maxLength": 350
                          },
                          "Name": {
                            "description": "Long name associated with the code",
                            "type": "string",
                            "minLength": 1,
                            "maxLength": 70
                          },
                          "Code": {
                            "description": "The four letter Mnemonic used within an XML file to identify a code",
                            "type": "string",
                            "pattern": "[A-Z]{4}"
                          }
                        },
                        "required": ["Name", "Code"],
                        "additionalProperties": false
                      }
                    },
                    "Site": {
                      "description": "Used by a Financial Institution internally to identify the location of an ATM.",
                      "type": "object",
                      "properties": {
                        "Identification": {
                          "description": "ATM site identification for the Financial Institution.",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 35
                        },
                        "Name": {
                          "description": "ATM site name as used by Financial Institution.",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 140
                        }
                      },
                      "additionalProperties": false
                    },
                    "PostalAddress": {
                      "description": "Information that locates and identifies a specific address, as defined by postal services or in free format text.",
                      "type": "object",
                      "properties": {
                        "AddressLine": {
                          "description": "Information that locates and identifies a specific address, as defined by postal services, that is presented in free format text.",
                          "minItems": 0,
                          "maxItems": 7,
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 70
                        },
                        "BuildingNumber": {
                          "description": "Number that identifies the position of a building on a street.",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 350
                        },
                        "StreetName": {
                          "description": "Name of a street or thoroughfare",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 70
                        },
                        "TownName": {
                          "description": "Name of a built-up area, with defined boundaries, and a local government.",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 35
                        },
                        "CountrySubDivision": {
                          "description": "Identifies a subdivision of a country, for instance state, region, county.",
                          "maxItems": 2,
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 35
                        },
                        "Country": {
                          "description": "Nation with its own government, occupying a particular territory.",
                          "type": "string",
                          "pattern": "[A-Z]{2}"
                        },
                        "PostCode": {
                          "description": "Identifier consisting of a group of letters and/or numbers that is added to a postal address to assist the sorting of mail",
                          "type": "string",
                          "minLength": 1,
                          "maxLength": 16
                        },
                        "GeoLocation": {
                          "description": "Geographic location of the ATM specified by geographic coordinates or UTM coordinates.",
                          "type": "object",
                          "properties": {
                            "GeoLocation": {
                              "description": "Location on the Earth specified by two numbers representing vertical and horizontal position.",
                              "type": "object",
                              "properties": {
                                "Latitude": {
                                  "description": "The Latitude measured in decimal format according to ISO 213",
                                  "type": "string",
                                  "pattern": "^-?\\d{1,3}\\.\\d{1,8}$"
                                },
                                "Longitude": {
                                  "description": "The longitude measured in decimal format according to ISO 213",
                                  "type": "string",
                                  "pattern": "^-?\\d{1,3}\\.\\d{1,8}$"
                                }
                              },
                              "required": ["Latitude", "Longitude"],
                              "additionalProperties": false
                            }
                          },
                          "required": ["Geolocation"],
                          "additionalProperties": false
                        }
                      },
                      "required": ["Postcode"],
                      "additionalProperties": false
                    }
                  },
                  "required": ["PostalAddress"],
                  "additionalProperties": false
                }
              },
              "required": ["Identification", "SupportedCurrency", "Location"],
              "additionalProperties": false
            }
          }
        },
        "required": ["BrandName", "ATM"],
        "additionalProperties": false
      }
    }
  },
  "required": ["Brand"],
  "additionalProperties": false
}
;
run;

proc http
 url= "&fullurl."
 method="GET"
 out=topics;
run;

title "Using custom JSON map";
libname posts json fileref=topics map=minmap;
proc datasets lib=posts; quit;

data messages;
 set posts.messages;
run;

proc print data=messages; run;
