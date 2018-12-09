package com.dhua.osctutorial;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.app.Activity;
import com.dhua.osctutorial.Osc;

public class MainActivity extends Activity {

    EditText ip;
    Osc osc;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }
    public void showEarth(View view){
        ip   = (EditText)findViewById(R.id.ip);
        osc.oscRequest(ip.getText().toString(), "earth");

    }
    public void showMars(View view){
        ip   = (EditText)findViewById(R.id.ip);
        osc.oscRequest(ip.getText().toString(), "mars");

    }
    public void showMoon(View view){
        ip   = (EditText)findViewById(R.id.ip);
        osc.oscRequest(ip.getText().toString(), "moon");

    }
    public void showSky(View view){
        ip   = (EditText)findViewById(R.id.ip);
        osc.oscRequest(ip.getText().toString(), "sky");

    }

    public void delhi(View view) {
        ip   = (EditText)findViewById(R.id.ip);
        final String latlong   ="New Delhi,77.1025,28.7041";
        osc.oscRequest(ip.getText().toString(), latlong);
    }

    public void newYork(View view) {
        ip   = (EditText)findViewById(R.id.ip);
        final String latlong   ="New York City,-74.006028,40.7128";
        osc.oscRequest(ip.getText().toString(), latlong);
    }

    public void sanJose(View view) {
        ip   = (EditText)findViewById(R.id.ip);
        final String latlong   ="San Jose,-121.886328,37.3382";
        osc.oscRequest(ip.getText().toString(), latlong);
    }

    public void shanghai(View view) {
        ip   = (EditText)findViewById(R.id.ip);
        final String latlong   ="Shanghai,121.4737,31.2304";
        osc.oscRequest(ip.getText().toString(), latlong);
    }

    public void london(View view) {
        ip   = (EditText)findViewById(R.id.ip);
        final String latlong   ="London,0.127,51.5074";
        osc.oscRequest(ip.getText().toString(), latlong);
    }
}
