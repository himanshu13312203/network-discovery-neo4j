// ===============================================
// Network Discovery Neo4j Graph Queries
// Description: Helpful Cypher queries to inspect
// and visualize the network topology
// ===============================================

//
// 1. View All Hosts and Their Interfaces
//
MATCH (h:Host)-[r:HAS_INTERFACE]->(i:Interface)
RETURN h, r, i;


//
// 2. View Host → Interface → IP with Relationships
//
MATCH (h:Host)-[r1:HAS_INTERFACE]->(i:Interface)-[r2:HAS_IP]->(ip:IP)
RETURN h, r1, i, r2, ip
ORDER BY h.name;


//
// 3. View Subnet Info with Connected IPs
//
MATCH (ip:IP)-[r:BELONGS_TO]->(s:Subnet)
RETURN ip, r, s;


//
// 4. Full Graph: Host → Interface → IP → Subnet
//
MATCH (h:Host)-[r1:HAS_INTERFACE]->(i:Interface)-[r2:HAS_IP]->(ip:IP)-[r3:BELONGS_TO]->(s:Subnet)
RETURN h, r1, i, r2, ip, r3, s;


//
// 5. List All IPs With Their Subnet (with relationships)
//
MATCH (ip:IP)-[r:BELONGS_TO]->(s:Subnet)
RETURN ip, r, s
ORDER BY ip.address;


//
// 6. Check Primary vs Secondary Interfaces (with relationships)
//
MATCH (h:Host)-[r:HAS_INTERFACE]->(i:Interface)
RETURN h, r, i
ORDER BY h.name;


//
// 7. Find Hosts with Multiple Interfaces + Show Links
//
MATCH (h:Host)-[r:HAS_INTERFACE]->(i:Interface)
WITH h, collect(i) AS interfaces, collect(r) AS relations
WHERE size(interfaces) > 1
UNWIND interfaces AS i
UNWIND relations AS r
RETURN h, r, i;


//
// 8. Count Hosts, IPs, Subnets
//
MATCH (h:Host) RETURN count(h) AS Total_Hosts;
MATCH (ip:IP) RETURN count(ip) AS Total_IPs;
MATCH (s:Subnet) RETURN count(s) AS Total_Subnets;


//
// 9.  Show All Nodes and All Relationships
//
MATCH (n)-[r]->(m)
RETURN n, r, m;
