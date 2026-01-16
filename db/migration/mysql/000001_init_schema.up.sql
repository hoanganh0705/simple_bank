CREATE TABLE accounts (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  owner VARCHAR(255) NOT NULL,
  balance BIGINT NOT NULL,
  currency VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE entries (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  account_id BIGINT NOT NULL,
  amount BIGINT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_entries_account
    FOREIGN KEY (account_id) REFERENCES accounts(id)
) ENGINE=InnoDB;

CREATE TABLE transfers (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  from_account_id BIGINT NOT NULL,
  to_account_id BIGINT NOT NULL,
  amount BIGINT NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_transfers_from_account
    FOREIGN KEY (from_account_id) REFERENCES accounts(id),
  CONSTRAINT fk_transfers_to_account
    FOREIGN KEY (to_account_id) REFERENCES accounts(id)
) ENGINE=InnoDB;

CREATE INDEX idx_accounts_owner ON accounts(owner);
CREATE INDEX idx_entries_account_id ON entries(account_id);
CREATE INDEX idx_transfers_from_account_id ON transfers(from_account_id);
CREATE INDEX idx_transfers_to_account_id ON transfers(to_account_id);
CREATE INDEX idx_transfers_from_to_account_id 
  ON transfers(from_account_id, to_account_id);
