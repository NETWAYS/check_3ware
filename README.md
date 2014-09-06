check_3ware
===========
A collection of perlscripts to query 3ware raidcontrollers with the tw\_cli tool.


####Options:
<table>
    <tr>
        <th>check_3ware.pl</th>
        <th>Flag</th>
        <th>Description</th>
    </tr>
    
    <tr>
        <td></td>
        <td>--help, -h</td>
        <td>help screen</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--usage</td>
        <td>little usage</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--controller, -C</td>
        <td>Controller ID</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--unit, -U</td>
        <td>Unit ID</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--warnings, -W</td>
        <td>Displays warning Keywords</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--okays, -O</td>
        <td>Displays ok Keywords</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--version, -V</td>
        <td>Display version</td>
    </tr>
    <tr>
        <th>check_dpti.pl</th>
        <th>Flag</th>
        <th>Description</th>
    </tr>
    
    <tr>
        <td></td>
        <td>--help, -h</td>
        <td>help screen.</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--usage</td>
        <td>little usage</td>
    </tr>
    
    <tr>
        <td></td>
        <td>--controller, -C</td>
        <td>Controller ID</td>
    </tr>
    
</table>

####Usage:
<pre><code>check_3ware.pl -C 0 -U 0 (checks Controller 0 Unit 0 for status)
check_3ware.pl -W (Displays all Warning keywords)
check_3ware.pl -O (Displays all OK keywords)

check_dpti.pl -C 0  (checks Controller 0)
</code></pre>
