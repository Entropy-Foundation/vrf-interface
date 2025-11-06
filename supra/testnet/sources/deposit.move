module supra_addr::deposit {

    /// Capability struct for VRF module permissions
    struct SupraVRFPermit<phantom T> has store {}

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
}
