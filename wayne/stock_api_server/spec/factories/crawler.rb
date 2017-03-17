FactoryGirl.define do
  factory :crawler do
    # equal to first data (stock_change positive)
    plain_data do
      {
        stock_code: '2328',
        stock_name: '測試',
        stock_company_uri: 'http://stock.wearn.com/a2328.html',
        stock_opening_price: 31.3,
        stock_highest_price: 32.2,
        stock_lowest_price: 30.3,
        stock_closing_yesterday: 30.5,
        stock_closing_today: 30.55,
        stock_volume: 98_887,
        stock_change: 0.05,
        stock_quote_change: 0.16
      }
    end

    # normal html
    html do
      <<-HTML_END
      <!DOCTYPE html>
      <html>
      <head></head>
      <body>
        <div class="stockalllist">
          <table width="696" border="0" align="center" cellpadding="0" cellspacing="0" style="float:left;margin-left: 60px;">
            <!-- stock_change positive -->
            <tr class="stockalllistbg2">
              <td>1</td>
              <td>2328</td>
              <td>
                <a href="http://stock.wearn.com/a2328.html">
                  <font size="3">測試</font>
                </a>
              </td>
              <td align="right">31.30&nbsp;&nbsp;</td>
              <td align="right">32.20&nbsp;&nbsp;</td>
              <td align="right">30.30&nbsp;&nbsp;</td>
              <td align="right">30.50&nbsp;&nbsp;</td>
              <td align="right">30.55&nbsp;&nbsp;</td>
              <td align="right">
                <font color="#0000FF">98,887&nbsp;&nbsp;</font>
              </td>
              <td>
                <table border="0" width="100%" style="border:none">
                  <tr>
                    <td style="font-size:13px;border:none">
                      <font color=#ec008c>▲</font>
                    </td>
                    <td style="border:none">
                      <font color=#ec008c>0.05</font>
                    </td>
                  </tr>
                </table>
              </td>
              <td align="right">0.16%&nbsp;&nbsp;</td>
            </tr>
            <!-- stock_change nagative -->
            <tr class="stockalllistbg1">
              <td>1</td>
              <td>2328</td>
              <td>
                <a href="http://stock.wearn.com/a2328.html">
                  <font size="3">測試</font>
                </a>
              </td>
              <td align="right">31.30&nbsp;&nbsp;</td>
              <td align="right">32.20&nbsp;&nbsp;</td>
              <td align="right">30.30&nbsp;&nbsp;</td>
              <td align="right">30.50&nbsp;&nbsp;</td>
              <td align="right">30.55&nbsp;&nbsp;</td>
              <td align="right">
                <font color="#0000FF">98,887&nbsp;&nbsp;</font>
              </td>
              <td>
                <table border="0" width="100%" style="border:none">
                  <tr>
                    <td style="font-size:13px;border:none">
                      <font color=#009900>▼</font>
                    </td>
                    <td style="border:none">
                      <font color=#009900>0.05</font>
                    </td>
                  </tr>
                </table>
              </td>
              <td align="right">0.16%&nbsp;&nbsp;</td>
            </tr>
            <!-- stock_change zero -->
            <tr class="stockalllistbg2">
              <td>1</td>
              <td>2328</td>
              <td>
                <a href="http://stock.wearn.com/a2328.html">
                  <font size="3">測試</font>
                </a>
              </td>
              <td align="right">31.30&nbsp;&nbsp;</td>
              <td align="right">32.20&nbsp;&nbsp;</td>
              <td align="right">30.30&nbsp;&nbsp;</td>
              <td align="right">30.50&nbsp;&nbsp;</td>
              <td align="right">30.55&nbsp;&nbsp;</td>
              <td align="right">
                <font color="#0000FF">98,887&nbsp;&nbsp;</font>
              </td>
              <td>
                <table border="0" width="100%" style="border:none">
                  <tr>
                    <td style="font-size:13px;border:none">
                    ─          </td>
                    <td style="border:none">
                    0</td>
                  </tr>
                </table>
              </td>
              <td align="right">0.16%&nbsp;&nbsp;</td>
            </tr>
          </table>
        </div>
      </body>
      </html>
      HTML_END
    end
  end
end
