import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FileUtils {

    public static List<String> readFromFile(String filename) {
        List<String> list = new ArrayList<>();
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(filename))) {
            String line = bufferedReader.readLine();
            while (line != null) {
                String[] words = line.split(" ");
                for (String each : words) {
                    if (each.length() > 0)
                        list.add(each);
                }
                line = bufferedReader.readLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void writeToFile(String filename, ArrayList<?> array) {
        try (BufferedWriter bufferedWriter = new BufferedWriter(new FileWriter(filename))) {
            for (Object each : array) {
                bufferedWriter.write(each.toString());
                bufferedWriter.newLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
