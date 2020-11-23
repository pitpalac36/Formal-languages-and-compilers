public class FIP {

    private int codAtom;
    private int codTS;

    public FIP(int codAtom, int codTS) {
        this.codAtom = codAtom;
        this.codTS = codTS;
    }

    @Override
    public String toString() {
        return "cod atom: " + codAtom + "   cod TS: " + codTS + "\n";
    }

}