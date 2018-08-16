if (x_0 == 1 && y_0 == 1) {
        if (deep <= Total_step - 1)
            qipan[2][1] = 1;
        else        qipan[2][1] = 0;
    }
    if (x_0 == 1 && y_0 == Columns) {
        if (deep <= Total_step - 1)
            qipan[2][Columns-2] = 1;
        else  qipan[2][Columns - 2] = 0;
    }
    if (x_0 == Row && y_0 == Columns) {
        if (deep <= Total_step - 1)
            qipan[Row-3][Columns - 2] = 1;
        else  qipan[Row - 3][Columns - 2] = 0;
    }
    if (x_0 == Row && y_0 == 1) {
        if (deep <= Total_step - 1)
            qipan[Row - 2][2] = 1;
        else  qipan[Row - 2][ 2] = 0;
    }
