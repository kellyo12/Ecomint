;; -------------------------------------------------
;; EcoMint-STX: Green Certification NFT Contract
;; -------------------------------------------------

(define-trait sip009-nft
  (
    (get-last-token-id () (response uint uint))
    (get-owner (uint) (response (optional principal) uint))
    (transfer (uint principal principal) (response bool uint))
  )
)

;; ---------------------------
;; Data Maps & Variables
;; ---------------------------

(define-constant contract-deployer (as-contract tx-sender))

(define-map eco-nfts
  { id: uint }
  { owner: principal, metadata: (string-ascii 100) })

(define-map verified-issuers
  { issuer: principal }
  { approved: bool })

(define-data-var last-token-id uint u0)

;; ---------------------------
;; Errors
;; ---------------------------
(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-NOT-OWNER (err u101))
(define-constant ERR-NOT-VERIFIED (err u102))
(define-constant ERR-TOKEN-NOT-FOUND (err u103))

;; ---------------------------
;; Admin Functions
;; ---------------------------

(define-public (add-issuer (issuer principal))
  (begin
    (asserts! (is-eq tx-sender contract-deployer) ERR-NOT-AUTHORIZED)
    (map-set verified-issuers { issuer: issuer } { approved: true })
    (ok true)
  )
)

;; ---------------------------
;; Core Functions
;; ---------------------------

;; Mint NFT for eco-action
(define-public (mint (recipient principal) (metadata (string-ascii 100)))
  (let (
        (issuer (map-get? verified-issuers { issuer: tx-sender }))
       )
    (begin
      (asserts! (and (is-some issuer) (get approved (unwrap! issuer ERR-NOT-VERIFIED))) ERR-NOT-VERIFIED)
      (var-set last-token-id (+ (var-get last-token-id) u1))
      (let ((token-id (var-get last-token-id)))
        (map-set eco-nfts { id: token-id } { owner: recipient, metadata: metadata })
        (ok token-id)
      )
    )
  )
)

;; Transfer NFT
(define-public (transfer (token-id uint) (to principal))
  (let ((nft (map-get? eco-nfts { id: token-id })))
    (begin
      (asserts! (is-some nft) ERR-TOKEN-NOT-FOUND)
      (let ((owner (get owner (unwrap! nft ERR-TOKEN-NOT-FOUND))))
        (asserts! (is-eq tx-sender owner) ERR-NOT-OWNER)
        (map-set eco-nfts { id: token-id } { owner: to, metadata: (get metadata (unwrap! nft ERR-TOKEN-NOT-FOUND)) })
        (ok true)
      )
    )
  )
)

;; ---------------------------
;; Read-Only Functions
;; ---------------------------

(define-read-only (get-owner (token-id uint))
  (match (map-get? eco-nfts { id: token-id })
    nft (ok (some (get owner nft)))
    (err u404)
  )
)

(define-read-only (get-last-token-id)
  (ok (var-get last-token-id))
)

(define-read-only (get-metadata (token-id uint))
  (match (map-get? eco-nfts { id: token-id })
    nft (ok (get metadata nft))
    (err u404)
  )
)
