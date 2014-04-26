import std.stdio, std.string;

void main() {
   // Assoc array of string -> uint, for some reason.
   uint[string] dict;
   foreach(line; stdin.byLine()) {
      // idup creates an immutable copy...
      // Don't entirely understand why this is necessary.
      string[] words = split(line.idup);
      foreach(word; words) {
	 if(word in dict) {
	    dict[word] += 1;
	 } else {
	    dict[word] = 1;
	 }
      }
   }
   foreach(word, ct; dict) {
      writefln("%s: %s", word, ct);
   }
}