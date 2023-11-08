// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2;

contract ServReqContract {
	
    struct CoverageEligibilityRequest {
        string purpose;
        MedicationRequest[] item;
        Patient patient;

        MedicationRequest immunoTherapyItem;
    }

    struct MedicationRequest {
        Medication[] medication;

        Procedure eligibleTransplant;

        bool exists;
    }

    struct Medication {
        string concept;

        bool exists;
    }

    struct Patient {
        string id;
        Claim[] subjectOf;
        Coverage[] policyHolderOf;

        bool exists;
    }

    struct Claim {
        Procedure procedure;
        Coverage insurance;
    
        bool exists;
    }

    struct Procedure {
        string status;
        uint256 code;

        bool exists;
    }

    struct Coverage {
        string insurer;
        string class;
        string status;

        bool exists;
    }

    struct CoverageEligibilityResponse {
        MedicationRequest request;
        string outcome;
    }
	
    // error:
    // UnimplementedFeatureError: Copying of type struct memory[] memory to storage not yet supported.
    // CoverageEligibilityRequest reqField;

    constructor() {
	}
	
	// event Response(uint number);
    // event Response(string msg);
    event Response(CoverageEligibilityResponse response);

	// function execute(uint256 input) public {
        // if (input > 1) {
        //     emit RecommendDiabetesScreening(block.timestamp);
        // }
    // function execute(string memory input) public {
    //     emit RecommendDiabetesScreening(input);

    // function execute(CoverageEligibilityRequest memory input) public {
    //     if (input.number > 1) {
    //         emit RecommendDiabetesScreening(input.number);
    //     }

    function check0(MedicationRequest memory item) pure private returns (bool) {
        for (uint i = 0; i < item.medication.length; i++) {
            Medication memory med = item.medication[i];
            if (keccak256(abi.encodePacked(med.concept)) == keccak256("DBCAT005063")) {
                return true;
            }
        }
        return false;
    }

    function execute(CoverageEligibilityRequest memory req) public {
        // reqField = req;

        if (keccak256(abi.encodePacked(req.purpose)) == keccak256("validation")) {
            for (uint i = 0; i < req.item.length; i++) {
                MedicationRequest memory item = req.item[i];
                if (check0(item)) {
                    req.immunoTherapyItem = item;
                    break;
                }
            }
        }

        if (req.immunoTherapyItem.exists) {
            externalServiceRequest(1, "myfhir.ca", "Claim", [ [ "subject", req.patient.id ], [ "", "" ] ], req);
        }
	}

    function externalServiceResponse1(CoverageEligibilityRequest memory req, Claim[] memory claims) public {
        for (uint i = 0; i < claims.length; i++) {
            Claim memory claim = claims[i];

            if (keccak256(abi.encodePacked(claim.procedure.status)) == keccak256("completed") &&
                claim.procedure.code == 77465005 && 
                keccak256(abi.encodePacked(claim.insurance.insurer)) == keccak256("Medicare") &&
                keccak256(abi.encodePacked(claim.insurance.class)) == keccak256("PartA")
            ) {
                req.immunoTherapyItem.eligibleTransplant = claim.procedure;
                break;
            }
        }

        if (req.immunoTherapyItem.exists && 
            req.immunoTherapyItem.eligibleTransplant.exists) {

                externalServiceRequest(2, "myfhir.ca", "Coverage", [ [ "policyHolder", req.patient.id ], [ "status", "active" ] ], req);
            }
    }

    function externalServiceResponse2(CoverageEligibilityRequest memory req, Coverage[] memory coverages) public {
        for (uint i = 0; i < coverages.length; i++) {
            Coverage memory cov = coverages[i];

            if (keccak256(abi.encodePacked(cov.status)) == keccak256("active") && 
                keccak256(abi.encodePacked(cov.insurer)) == keccak256("Medicare") &&
                (keccak256(abi.encodePacked(cov.class)) == keccak256("PartB") || keccak256(abi.encodePacked(cov.class)) == keccak256("PartD"))
            ) {
                CoverageEligibilityResponse memory response = CoverageEligibilityResponse({ request: req.immunoTherapyItem, outcome: 'complete' });
                emit Response(response);
            }
        }
    }

    function externalServiceRequest(uint256 id, string memory url, string memory typeParam, string[2][2] memory parameters, CoverageEligibilityRequest memory req) private {
        if (id == 1) {
            Procedure memory proc = Procedure({ status: "completed", code: 77465005, exists: true });
            Coverage memory cov = Coverage({ insurer: "Medicare", class: "PartA", status: "completed", exists: true });
            Claim memory claim = Claim({ procedure: proc, insurance: cov, exists: true });

            Claim[] memory claims = new Claim[](1);
            claims[0] = claim;

            externalServiceResponse1(req, claims);

        } else if (id == 2) {
            Coverage memory cov = Coverage({ insurer: "Medicare", class: "PartD", status: "active", exists: true });

            Coverage[] memory coverages = new Coverage[](1);
            coverages[0] = cov;

            externalServiceResponse2(req, coverages);
        }
    }
}