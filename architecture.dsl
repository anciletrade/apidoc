workspace "Day Trader Insurance Platform" "Architecture for a low-cost, low-latency day trading insurance application"{

 

    model {

        // Define the user
        user = person "Trader" {
            description "A day trader who purchases trade insurance and executes trades through the platform."
        }
 // Define external systems
            brokerApi = softwareSystem "Broker API" {
                description "External broker API for executing trades on connected brokerage accounts."
                tags "External System"
            }

            bankApi = softwareSystem "Bank API" {
                description "External bank API for handling fund withdrawals."
                tags "External System"
            }
        // Define the main software system
        system = softwareSystem "Day Trader Insurance Platform" {
            
            // Define core microservices as containers
            accountService = container "User and Account Management Service" {
                description "Manages user profiles, brokerage account connections, and wallets."
                technology "Microservice"
                tags "Microservice"
                # db = container "User Database" {
                #     description "Stores user data and account information."
                #     technology "MongoDB"
                #     tags "Database"
                # }
            }

            insuranceService = container "Insurance Management Service" {
                description "Manages insurance plans, coverage options, and loss reimbursements."
                technology "Microservice"
                tags "Microservice"
                # db = container "Insurance Database" {
                #     description "Stores insurance plans, user coverage, and reimbursement records."
                #     technology "MongoDB"
                #     tags "Database"
                # }
            }

            tradingService = container "Trading Service" {
                description "Provides real-time trading interface, market data, and trade execution."
                technology "Microservice"
                tags "Microservice"
                # db = container "Trading Database" {
                #     description "Stores trade records for tracking and reporting."
                #     technology "MongoDB"
                #     tags "Database"
                # }
            }

            paymentService = container "Payment and Reimbursement Service" {
                description "Handles payment of premiums, fund deposits, withdrawals, and reimbursements."
                technology "Microservice"
                tags "Microservice"
                # db = container "Payment Database" {
                #     description "Records transactions, including payments, deposits, and reimbursements."
                #     technology "MongoDB"
                #     tags "Database"
                # }
            }

            notificationService = container "Notification and Reporting Service" {
                description "Manages user notifications and generates daily reports for administrators."
                technology "Microservice"
                tags "Microservice"
                # db = container "Notification and Reporting Database" {
                #     description "Stores notification records and generated reports."
                #     technology "MongoDB"
                #     tags "Database"
                # }
            }

           

            // Define interactions
            user -> system "Registers, connects broker accounts, deposits funds, trades, receives reimbursements"
            user -> accountService "Registers, manages accounts, connects brokers"
            user -> insuranceService "Selects insurance plans, views coverage"
            user -> tradingService "Views market data, places trades"
            user -> paymentService "Makes deposits, pays premiums, requests reimbursements"
            user -> notificationService "Receives alerts and notifications"
            
            accountService -> brokerApi "Connects broker accounts"
            tradingService -> brokerApi "Executes trades"
            paymentService -> bankApi "Handles withdrawals to bank accounts"
        }
    }

    views {

        systemContext system "System_Context" {
            include *
            autolayout lr
        }

        container system "Container_Diagram" {
            include *
            autolayout lr
        }
    }

}