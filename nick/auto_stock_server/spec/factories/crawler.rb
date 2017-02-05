FactoryGirl.define do
  factory :crawler do
    # normal html
    html do
      <<-HTML_END
      <!DOCTYPE html>
      <html>
        <head></head>
        <body>
          <tr class="stockalllistbg2">
          <td>1</td>
          <td>2371</td>
          <td><a href="http://stock.wearn.com/a2371.html"><font size="3">大同</font></a></td>
          <td align="right">18.85&nbsp;&nbsp;</td>
          <td align="right">19.85&nbsp;&nbsp;</td>
          <td align="right">16.65&nbsp;&nbsp;</td>
          <td align="right">
            18.35&nbsp;&nbsp;    </td>
          <td align="right">16.95&nbsp;&nbsp;</td>
          <td align="right"><font color="#0000FF">217,077&nbsp;&nbsp;</font></td>
          <td><table border="0" width="100%" style="border:none">
              <tr>
                <td style="font-size:13px;border:none">
                  <font color=#009900>▼</font>          </td>
                <td style="border:none">
                  <font color=#009900>1.40</font></td>
              </tr>
            </table></td>
          <td align="right">-7.63%&nbsp;&nbsp;</td>
          </tr>
        </body>
      </html>
      HTML_END
    end

    # empty html template
    html_empty do
      <<-HTML_END
      <!DOCTYPE html>
      <html>
        <head></head>
        <body></body>
      </html>
      HTML_END
    end
    # change is nagetive
    change_nagative do
      <<-HTML_END
        <!DOCTYPE html>
        <html>
          <head></head>
          <body>
            <tr class="stockalllistbg2">
            <td>1</td>
            <td>2371</td>
            <td><a href="http://stock.wearn.com/a2371.html"><font size="3">大同</font></a></td>
            <td align="right">18.85&nbsp;&nbsp;</td>
            <td align="right">19.85&nbsp;&nbsp;</td>
            <td align="right">16.65&nbsp;&nbsp;</td>
            <td align="right">
              18.35&nbsp;&nbsp;    </td>
            <td align="right">16.95&nbsp;&nbsp;</td>
            <td align="right"><font color="#0000FF">217,077&nbsp;&nbsp;</font></td>
            <td><table border="0" width="100%" style="border:none">
                <tr>
                  <td style="font-size:13px;border:none">
                    <font color=#009900>▼</font>          </td>
                  <td style="border:none">
                    <font color=#009900>1.40</font></td>
                </tr>
              </table></td>
            <td align="right">-7.63%&nbsp;&nbsp;</td>
            </tr>
          </body>
        </html>
        HTML_END
    end

    # change is positive
    change_positive do
      <<-HTML_END
        <!DOCTYPE html>
        <html>
          <head></head>
          <body>
            <tr class="stockalllistbg2">
              <td>13</td>
              <td>2311</td>
              <td><a href="http://stock.wearn.com/a2311.html"><font size="3">日月光</font></a></td>
              <td align="right">36.90&nbsp;&nbsp;</td>
              <td align="right">37.50&nbsp;&nbsp;</td>
              <td align="right">36.75&nbsp;&nbsp;</td>
              <td align="right">
                36.55&nbsp;&nbsp;    </td>
              <td align="right">37.50&nbsp;&nbsp;</td>
              <td align="right"><font color="#0000FF">41,461&nbsp;&nbsp;</font></td>

              <td><table border="0" width="100%" style="border:none">
                  <tr>
                    <td style="font-size:13px;border:none">
                      <font color=#ec008c>▲</font>          </td>
                    <td style="border:none">
                      <font color=#ec008c>0.95</font></td>
                  </tr>
                </table></td>
              <td align="right">2.60%&nbsp;&nbsp;</td>
            </tr>
          </body>
        </html>
        HTML_END
    end

    # change is equal to 0
    change_zero do
      <<-HTML_END
      <!DOCTYPE html>
      <html>
        <head></head>
        <body>
          <tr class="stockalllistbg2">
            <td>19</td>
          <td>2330</td>
            <td><a href="http://stock.wearn.com/a2330.html"><font size="3">台積電</font></a></td>
            <td align="right">186.00&nbsp;&nbsp;</td>
            <td align="right">186.00&nbsp;&nbsp;</td>
            <td align="right">183.50&nbsp;&nbsp;</td>
            <td align="right">
              184.50&nbsp;&nbsp;    </td>
            <td align="right">184.50&nbsp;&nbsp;</td>
            <td align="right"><font color="#0000FF">29,508&nbsp;&nbsp;</font></td>
            <td><table border="0" width="100%" style="border:none">
                <tr>
                  <td style="font-size:13px;border:none">
                    ─          </td>
                  <td style="border:none">
                    0</td>
                </tr>
              </table></td>
            <td align="right">0.00%&nbsp;&nbsp;</td>
          </tr>
        </body>
      </html>
      HTML_END
    end
  end
end
