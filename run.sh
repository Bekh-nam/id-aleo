#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

# Follow along in the README.md for a detailed explanation of each step.

# The private key and address of the user.
# Swap these into program.json, when running transactions.
# "private_key": "APrivateKey1zkp8wYsJ79xGvGMSQBkh2VLo3NxPZajbQZiZ2zbTVPmBAau"
# "address": aleo1vw7q53aea30xlk57fu6gnhdgcwqvh9arxcka30rctldmly67vugqk5zgpx

# 1: Create ID
echo "
###############################################################################
########                                                               ########
########                         Create ID                             ########
########                                                               ########
###############################################################################
"
echo "{
  \"program\": \"id.aleo\",
  \"version\": \"0.0.0\",
  \"description\": \"Decentralized Identity\",
  \"development\": {
      \"private_key\": \"APrivateKey1zkp8wYsJ79xGvGMSQBkh2VLo3NxPZajbQZiZ2zbTVPmBAau\",
      \"address\": \"aleo1vw7q53aea30xlk57fu6gnhdgcwqvh9arxcka30rctldmly67vugqk5zgpx\"
  },
  \"license\": \"MIT\"
}" > program.json
leo run create_id

echo "{
  creator: aleo1vw7q53aea30xlk57fu6gnhdgcwqvh9arxcka30rctldmly67vugqk5zgpx,
  id: 10010055439917326779u64
}"

# 2: Publish root associated to ID
echo "
###############################################################################
########                                                               ########
########                         Publish Root                          ########
########                                                               ########
###############################################################################
"
leo run publish_root 17646029704403646329262977545885904155278938368574073463104538741215567924227field

echo "✅ Successfully created id"

# 2: Bind proof associated to root
echo "
###############################################################################
########                                                               ########
########                         Bind proof                            ########
########                                                               ########
###############################################################################
"
leo run bind_proof 17646029704403646329262977545885904155278938368574073463104538741215567924227field 17646029704403646329262977545885904155278938368574073463104538741215567924227field

echo "{
  owner: aleo1vw7q53aea30xlk57fu6gnhdgcwqvh9arxcka30rctldmly67vugqk5zgpx.private,
  proof: 757106205546905480765327668322811092527139698265945807234071829380749446145field.private,
  _nonce: 2689819217668576743365574382169295401837283620535877699423830743635502680372group.public
}"