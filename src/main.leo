// The `program` scope defines the data types, functions, and state associated with the `id` program.
program id.aleo {
    // Store all id generated
    mapping ids: address => Id;
    // Store all root published
    mapping roots: field => Root;

    // Proof record records the proof needed to verify data.
    record Proof {
        owner: address;
        proof: field;
    }

    // Id details
    struct Id {
        creator: address;
        id: u64;
    }

    // Root details
    // - `root`       : The merkle root of bundled data.
    // - `created_by_id`: The ID published the root data.
    struct Root {
        root: field;
        created_by_id: Id;
    }

    // Returns the id binded to user.
    transition create_id() -> Id {
        let id: u64 = BHP256::hash_to_u64(self.caller);
        let id_data: Id = Id {
            creator: self.caller,
            id
        };
        return id_data then finalize(self.caller, id_data);
    }

    // Create a new id in the "ids" mapping
    finalize create_id(creator: address, id_data: Id) {
        assert(!Mapping::contains(ids, creator));
        Mapping::set(ids, creator, id_data);
    }

    // Returns a Root published by Id.
    // - `root` : The root of bundled data.
    transition publish_root(root: field) {
        // Return a new 'Root' record related to user's id.
        return then finalize(self.caller, root);
    }

    finalize publish_root(creator: address, root: field) {
        assert(!Mapping::contains(roots, root));
        let id: Id = Mapping::get(ids, creator);
        let root_data: Root = Root {
            root,
            created_by_id: id
        };
        Mapping::set(roots, root, root_data);
    }

    // Return a proof data record
    transition bind_proof(proof: field, root: field) -> Proof {
        return Proof {
            owner: self.caller,
            proof
        };
    }
}
