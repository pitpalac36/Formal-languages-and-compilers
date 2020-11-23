import java.util.ArrayList;

class Element {
    private int code;
    private String symbol;

    public Element(String symbol, int code) {
        this.symbol = symbol;
        this.code = code;
    }

    @Override
    public String toString() {
        return "simbol: " + symbol + "   cod TS: " + code + "\n";
    }

    public String getSymbol() {
        return symbol;
    }

    public int getCode() {
        return code;
    }
}

public class TS {

    private int maxSize;
    private int currentSize;
    private Element[] array;
    public static Integer currentPosition = 50;

    public TS(int maxSize) {
        this.maxSize = maxSize;
        this.currentSize = 0;
        this.array = new Element[maxSize];
    }

    public int size() {
        return currentSize;
    }

    public Element get(int index) {
        return array[index];
    }

    private void resize() {
        Element[] nou = new Element[2 * maxSize];
        for (int i = 0; i < maxSize; i++)
            nou[i] = this.array[i];
        this.maxSize = 2 * this.maxSize;
        this.array = nou;
    }

    void add(int position, Element element) {
        if (currentSize == maxSize)
            resize();
        for (int i = currentSize; i > position; i--)
            array[i] = array[i-1];
        this.currentSize++;
        array[position] = element;
    }

    public ArrayList<Element> asArray() {
        ArrayList<Element> list = new ArrayList<>();
        for (int i = 0; i < this.currentSize; i++)
            list.add(array[i]);
        return list;
    }

    public int insert(String word) {
        if (this.currentSize == 0) {
            this.add(0, new Element(word, this.currentPosition++));
            return 0;
        }

        else if (word.compareTo(this.get(0).getSymbol()) < 0) {
            this.add(0, new Element(word, this.currentPosition++));
            return 0;
        }

        else if (word.compareTo(this.get(this.size() - 1).getSymbol()) > 0) {
            this.add(this.size(), new Element(word, this.currentPosition++));
            return this.size() - 1;
        }

        else {
            int i = 0;
            while (word.compareTo(this.get(i).getSymbol()) > 0) i++;
            this.add(i, new Element(word, this.currentPosition++));
            return i;
        }
    }

    public int find(String word) {
        int position = -1;
        for (int i = 0; i < this.size(); i++)
            if (this.get(i).getSymbol().equals(word)) {
                position = i;
                break;
            }
        return position;
    }
}
