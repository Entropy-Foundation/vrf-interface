module supra_addr::deposit {


    use std::string::String;

    /// Capability struct for VRF module permissions
    struct SupraVRFPermit<phantom T> has store {}

    /// Client's module balance information return struct
    struct ClientModuleInfo has drop, copy {
        module_type_info: String,
        max_callback_txn_fee: u64,
        min_balance_limit: u64,
        balance: u64,
        enabled: bool,
        current_grant: u64
    }

    /// Whitelist a client address with specified configuration
    /// - max_txn_fee: Maximum transaction fee allowed for the client
    /// Automatically grants default supra amount to new clients
    native public entry fun whitelist_client_address(client: &signer,max_txn_fee: u64);

    /// Initialize VRF module for a client
    /// Returns a SupraVRFPermit capability that represents module authorization
    /// - T: Module type to be whitelisted
    native public fun init_vrf_module<T>(client: &signer): SupraVRFPermit<T>;

    /// Enable a module for VRF requests
    native public entry fun enable_module<T>(client: &signer);

    /// Disable a module from making VRF requests
    native public entry fun disable_module<T>(client: &signer);

    /// Remove a module from client's whitelist
    /// Consumes the SupraVRFPermit capability
    native public fun remove_module<T>(permit_cap: SupraVRFPermit<T>);

    /// Update maximum transaction fee for all modules of a client
    /// Automatically adjusts min_balance_limit based on new max_txn_fee
    native entry public fun update_max_txn_fee(user: &signer,max_txn_fee: u64);

    /// Update maximum callback transaction fee for a specific module
    /// Fee must not exceed client's max_txn_fee (if set)
    native public entry fun update_max_callback_txn_fee<T>(client: &signer,max_callback_txn_fee: u64);

    /// Deposit funds for V2 client
    /// Allows depositing on behalf of another client address
    native public entry fun deposit_fund_v2(sender: &signer, client_address: address,deposit_amount: u64);

    /// Client withdrawing deposit Supra coin
    native public entry fun withdraw_fund(sender: &signer, withdraw_amount: u64);

    #[view]
    /// Check if client is whitelisted (V2)
    native public fun is_client_whitelisted_v2(client_address: address): bool;

    #[view]
    /// Get client's current balance
    native public fun check_client_fund(client_address: address): u64;

    #[view]
    /// Get client's minimum balance requirement (V2)
    native public fun check_min_balance_client_v2(client_address: address): u64;

    #[view]
    /// Get client's maximum transaction fee (V2)
    native public fun check_max_txn_fee_client_v2(client_address: address): u64;

    #[view]
    /// Get client's remaining grant amount
    native public fun get_client_remaining_grant(client_address: address): u64;

    #[view]
    /// Get information for all modules whitelisted by a client
    /// Returns a vector of ClientModuleInfo structs
    native public fun get_client_modules_info(client_address: address): vector<ClientModuleInfo>;
    }
