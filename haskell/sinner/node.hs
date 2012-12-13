{- node.hs
   This is a node type for a directed graph, and functions to manipulate it.
   Sinner uses a directed graph to represent different, and this is it.
   It also contains a list of all nodes, which makes it easier to search for
   a specific one if necessary.

   Simon Heath
   4/7/2003
-}

module Node
   where

-- A Node contains all the data needed for an area:  The name,
-- data/description, events, node number, and edge list.
data Node =
   Node { name    :: String,
	  dat     :: String,
	  events  :: [Int],   -- Define an event type!!
          number  :: Int,
	  edges   :: [Node]
	}


edgeExists srcNode dstNode =
   if filter (\ x -> x == dstNode) (edges srcNode)
   then True
   else False

-- adds an edge from srcNode to dstNode
-- Multiple edges are not allowed.
addEdge srcNode dstNode =
   if not (edgeExists srcNode dstNode)
   then srcNode{ edges = dstNode : edges }
   else srcNode

-- Removes an edge
delEdge srcNode dstNode =
   if edgeExists srcNode dstNode
   then
      srcNode {
         edges = (filter (\ x -> x /= dstNode) edges)
	 }
   else
      srcNode
