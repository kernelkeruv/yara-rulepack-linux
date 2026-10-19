/* Demonstration-only marker. Not a malware signature or security verdict. */
rule Synthetic_Linux_Lab_Marker
{
    meta:
        description = "Matches an inert synthetic text marker in a controlled fixture"
        author = "Grant Scott Turner"
        category = "lab-example"
        confidence = "demonstration-only"
    strings:
        $marker = "SYNTHETIC_LINUX_LAB_MARKER_5A7B" ascii
    condition:
        $marker
}
