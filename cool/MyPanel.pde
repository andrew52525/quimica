import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import javax.swing.event.*;

MyPanel controlPanel;

color paper = color(0);
int ballYPos=0;
int ballWidth=20;
int ballHeight=20;

//**************************************************************
//  Copy-paste from GuiGeene 
//**************************************************************

public class MyPanel extends JPanel {
  private JButton jcomp1;
  private JButton jcomp2;
  private JButton jcomp3;
  private JSlider jcomp4;
  private JSlider jcomp5;
  private JSlider jcomp6;

  public MyPanel() {
    //construct components
    jcomp1 = new JButton ("Click me!");
    jcomp2 = new JButton ("Button 2");
    jcomp3 = new JButton ("Button 3");
    jcomp4 = new JSlider (-100, 100);
    jcomp5 = new JSlider (0, 100);
    jcomp6 = new JSlider (0, 100);

    //-Example: add a action listener to this button:
    jcomp1.addActionListener(new Button1Click());
    //-Example: add a change listener to this slider:
    jcomp4.addChangeListener(new HSlider1Change());
    jcomp5.addChangeListener(new HSlider2Change());
    jcomp6.addChangeListener(new HSlider3Change());



    //set components properties
    jcomp4.setOrientation (JSlider.HORIZONTAL);
    jcomp4.setMinorTickSpacing (10);
    jcomp4.setMajorTickSpacing (50);
    jcomp4.setPaintTicks (true);
    jcomp4.setPaintLabels (true);
    jcomp5.setOrientation (JSlider.HORIZONTAL);
    jcomp5.setMinorTickSpacing (10);
    jcomp5.setMajorTickSpacing (50);
    jcomp5.setPaintTicks (true);
    jcomp5.setPaintLabels (true);
    jcomp6.setOrientation (JSlider.HORIZONTAL);
    jcomp6.setMinorTickSpacing (10);
    jcomp6.setMajorTickSpacing (50);
    jcomp6.setPaintTicks (true);
    jcomp6.setPaintLabels (true);

    //adjust size and set layout
    setPreferredSize (new Dimension (412, 179));
    setLayout (null);

    //add components
    add (jcomp1);
    add (jcomp2);
    add (jcomp3);
    add (jcomp4);
    add (jcomp5);
    add (jcomp6);

    //set component bounds (only needed by Absolute Positioning)
    jcomp1.setBounds (5, 5, 100, 20);
    jcomp2.setBounds (5, 60, 100, 20);
    jcomp3.setBounds (5, 115, 100, 20);
    jcomp4.setBounds (115, 5, 270, 50);
    jcomp5.setBounds (115, 60, 270, 50);
    jcomp6.setBounds (115, 115, 270, 50);
  }

  //-Comment out main by GuiGenee, we set up ourselves:

  /*    public static void main (String[] args) {
   JFrame frame = new JFrame ("MyPanel");
   frame.setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE);
   frame.getContentPane().add (new MyPanel());
   frame.pack();
   frame.setVisible (true);
   }
   */
}


//**************************************************************
//  This gets called when button is clicked
//**************************************************************

class Button1Click implements ActionListener
{
  public void actionPerformed(ActionEvent e)
  {
    JButton b = (JButton)e.getSource();
    b.setLabel("Thanks!");
    timer=millis()+1000;

    println("Click");
    paper = color(random(255), random(255), random(255));
  }
}

//**************************************************************
//  This gets called when slider is changed
//**************************************************************

class HSlider1Change implements ChangeListener
{
  public void stateChanged(ChangeEvent e)
  {
    JSlider source = (JSlider)e.getSource();
    ballYPos = (int)source.getValue();
  }
}

class HSlider2Change implements ChangeListener
{
  public void stateChanged(ChangeEvent e)
  {
    JSlider source = (JSlider)e.getSource();
    ballWidth = (int)source.getValue();

  }
}

class HSlider3Change implements ChangeListener
{
  public void stateChanged(ChangeEvent e)
  {
    JSlider source = (JSlider)e.getSource();
    ballHeight = (int)source.getValue();

  }
}