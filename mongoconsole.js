use htlzwettl;
    db.depts.insertOne({"DEPTNO":10, "DNAME":"ACCOUNTING", "LOC":"NEW YORK"});
    db.depts.insertOne({"DEPTNO":20, "DNAME":"RESEARCH", "LOC":"DALLAS"});
    db.depts.insertOne({"DEPTNO":30, "DNAME":"SALES", "LOC":"CHICAGO"});
    db.depts.insertOne({"DEPTNO":40, "DNAME":"OPERATIONS", "LOC":"BOSTON"});

    db.emps.insertOne({"id":7369, "ENAME":"SMITH","JOB":"CLERK","parent_id":7902,"HIREDATE":new Date("1980-12-17"),"SAL":800, "dept_id":20});
    db.emps.insertOne({"id":7499, "ENAME":"ALLEN","JOB":"SALESMAN","parent_id":7698,"HIREDATE":new Date("1981-02-20"),"SAL":1600, "COMM":300, "dept_id":30});
    db.emps.insertOne({"id":7521, "ENAME":"WARD","JOB":"SALESMAN","parent_id":7698,"HIREDATE":new Date("1981-02-22"),"SAL":1250, "COMM":500, "dept_id":30});
    db.emps.insertOne({"id":7566, "ENAME":"JONES","JOB":"MANAGER","parent_id":7839,"HIREDATE":new Date("1981-04-02"),"SAL":2975, "dept_id":20});
    db.emps.insertOne({"id":7654, "ENAME":"MARTIN","JOB":"SALESMAN","parent_id":7698,"HIREDATE":new Date("1981-09-28"),"SAL":1250, "COMM":1400, "dept_id":30});
    db.emps.insertOne({"id":7698, "ENAME":"BLAKE","JOB":"MANAGER","parent_id":7839,"HIREDATE":new Date("1981-05-01"),"SAL":2850, "dept_id":30});
    db.emps.insertOne({"id":7782, "ENAME":"CLARK","JOB":"MANAGER","parent_id":7902,"HIREDATE":new Date("1981-06-09"),"SAL":2450, "dept_id":30});
    db.emps.insertOne({"id":7788, "ENAME":"SCOTT","JOB":"ANALYST","parent_id":7566,"HIREDATE":new Date("1982-12-09"),"SAL":3000, "dept_id":20});
    db.emps.insertOne({"id":7839, "ENAME":"KING","JOB":"PRESIDENT","HIREDATE":new Date("1981-11-17"),"SAL":5000, "dept_id":10});
    db.emps.insertOne({"id":7844, "ENAME":"TURNER","JOB":"SALESMAN","parent_id":7698,"HIREDATE":new Date("1981-09-08"),"SAL":1500, "COMM":0, "dept_id":30});
    db.emps.insertOne({"id":7876, "ENAME":"ADAMS","JOB":"CLERK","parent_id":7788,"HIREDATE":new Date("1983-01-12"),"SAL":1100, "dept_id":20});
    db.emps.insertOne({"id":7900, "ENAME":"JAMES","JOB":"CLERK","parent_id":7698,"HIREDATE":new Date("1981-12-03"),"SAL":950, "dept_id":30});
    db.emps.insertOne({"id":7902, "ENAME":"FORD","JOB":"ANALYST","parent_id":7566,"HIREDATE":new Date("1981-12-03"),"SAL":3000, "dept_id":20});
    db.emps.insertOne({"id":7934, "ENAME":"MILLER","JOB":"CLERK","parent_id":7782,"HIREDATE":new Date("1982-01-23"),"SAL":1300, "dept_id":10});


// Übungen

    //1
    db.depts.find({});

    //2
    db.emps.find(
        {dept_id:10},
        {ENAME:1,JOB:1,HIREDATE:1}
        );

    //3
    db.emps.find(
        { JOB: "CLERK" },
        { ENAME: 1, JOB: 1, SAL: 1, _id: 0 }
        );

    //4
    db.emps.find(
        { dept_id: { $ne: 10 } }
        );

    //5
    db.emps.find({
        $expr: { $gt: ["$COMM", "$SAL"] }
        });

    //6
    db.emps.find({
        HIREDATE: ISODate("1981-12-03T00:00:00Z")
        });

    db.emps.find({HIREDATE: new Date("1981-12-03")},{_id:0})

    //7
    db.emps.find({
        $or: [
            { SAL: { $lt: 1250 } },
            { SAL: { $gt: 1600 } }
            ]
        },
        {
            ENAME: 1, SAL: 1, _id: 0
            });

    //8
    db.emps.find({
        JOB: { $nin: ["MANAGER", "PRESIDENT"] }
        });

    //9
    db.emps.find({
        ENAME: { $regex: /^..A/ }
        });

    //10
    db.emps.find({
        COMM: { $ne: null }
        },
        {
            id: 1, ENAME: 1, JOB: 1, _id: 0
            });

    //*
    db.emps.find({
        $and: [
            { dept_id: { $ne: 10 } },
            { dept_id: { $ne: 30 } }
            ]
        });

    //11
    db.emps.find().sort({ COMM: 1 });

    //12
    db.emps.find({ JOB: { $nin: ['Manager', 'President'] } })
        .sort({ dept_id: 1, HIREDATE: -1 });

    //13
    db.emps.find({ $expr: { $eq: [{ $strLenCP: "$ENAME" }, 6] } }, { ENAME: 1 });



    //14
    db.emps.aggregate([
        { $match: { dept_id: 30 } },
        { $project: {_id:0, "Mitarbeiter - Position": { $concat: ["$ENAME", " - ", "$JOB"] } } }
        ]);


    //15
    db.emps.aggregate([
        {
            $project: {
                SAL_COMM_SUM: { $add: ["$SAL", "$COMM"] }
                }
            }
        ]);

    //16
    db.emps.aggregate([
        {
            $project: {
                Name: "$ENAME",
                Monthly: "$SAL",
                Daily: { $divide: ["$SAL", 22] },
                Hourly: { $divide: ["$SAL", { $multiply: [22, 8] }] }
                }
            }
        ]);

    //17
    db.emps.aggregate([
        {
            $group: {
                _id: null,
                totalSalary: { $sum: "$SAL" }
                }
            }
        ]);

    //18
    db.emps.aggregate([
        {
            $addFields:
            {
                commFixed: { $ifNull: ["$comm", 250] }
            }
        },
        {
            $group:
            {
                _id: null,
                durchschnittliche_pr mie: { $avg: "$commFixed" }
            }
        }
    ])

    select * from emps;
    select count(id) from emps;
    select SUM(COMM + IFNULL(COMM, 250))/count(*) from emps;

db.getSiblingDB("htlzwettl").getCollection("emps").aggregate([
    {
        $group: {
            _id: {"JOB": "JOB"},
            durchschnittliche_praemie: {
                $avg: {
                    $add: [
                        "$COMM",
                        { $ifNull: ["$COMM", 250] }
                    ]
                }
             }
            }
        }
    ])

    //19
    db.emps.aggregate([
        { $match: { dept_id: 30 } },
        {
            $project: {
                "CountOfSal": { $cond: { if: { $ne: ["$sal", null] }, then: 1, else: 0 } },
                "CountOfComm": { $cond: { if: { $ne: ["$comm", null] }, then: 1, else: 0 } }
                }
            },
        {
            $group: {
                _id: null,
                "CountOfSal": { $sum: "$CountOfSal" },
                "CountOfComm": { $sum: "$CountOfComm" }
                }
            }
        ])


    //20
    db.emps.aggregate([
        { $group: { _id: "$JOB" } },
        { $count: "distinctJobCount" }
        ])

    //21
    db.emps.aggregate([
        {
            $group: {
                _id: "$parent_id"
                }
            }
        ])

    //21/2
    db.emps.aggregate([
        {
            $match: {
                parent_id: { $ne: null }
                }
            },
        {
            $group: {
                _id: "$parent_id"
                }
            },
        {
            $count: "distinct_parent_id_count"
            }
        ]);

    //22
    db.emps.aggregate([
            {
                $match: { dept_id: 30 }
                },
            {
                $group: {
                    _id: null,
                    SUM_SALARY: { $sum: "$SAL" },
                    COUNT_SALARY: { $sum: { $cond: [{ $ne: ["$SAL", null] }, 1, 0] } },
                    AVG_SALARY: {
                        $avg: {
                            $cond: [{ $ne: ["$SAL", null] }, "$SAL", null]
                            }
                        },
                    SUM_COMMISSION: {
                        $sum: { $ifNull: ["$COMM", 0] }
                        },
                    COUNT_COMMISSION: {
                        $sum: { $cond: [{ $ne: ["$COMM", null] }, 1, 0] }
                        },
                    AVG_COMMISSION: {
                        $avg: { $ifNull: ["$COMM", 0] }
                        }
                    }
                }
            ]);

        // 23
        db.emps.aggregate([
                {
                    $match: {
                        JOB: { $nin: ['MANAGER', 'PRESIDENT'] }
                        }
                    },
                {
                    $group: {
                        _id: "$dept_id",  // GROUP BY dept_id
                        UNIQUE_JOBS: { $addToSet: "$JOB" }  // DISTINCT JOB
                        }
                    },
                {
                    $project: {
                        dept_id: "$_id",
                        UNIQUE_JOBS: { $size: "$UNIQUE_JOBS" }  // Z hlt die Anzahl der verschiedenen JOBs
                        }
                    }
                ]);

        // 24

        db.emps.aggregate([
                {
                    $group: {
                        _id: "$dept_id",
                        employee_count: { $sum: 1 }
                        }
                    },
                {
                    $group: {
                        _id: null,
                        average_employee_count: { $avg: "$employee_count" }
                        }
                    }
                ])


        //25
            db.emps.find({
                JOB: { $in: ["MANAGER", "PRESIDENT"] }
                })


        //26
            db.emps.aggregate([
                {
                    $match: {
                        $expr: {
                            $gt: ["$COMM", { $multiply: [0.25, "$SAL"] }]
                            }
                        }
                    },
                {
                    $project: {
                        _id: 0,
                        ENAME: 1,
                        JOB: 1,
                        COMM: 1
                        }
                    }
                ])

    //27
        db.emps.aggregate([
            {
                $project: {
                    totalCompensation: {
                        $add: [
                            "$SAL",
                            { $ifNull: ["$COMM", 0] }
                            ]
                        }
                    }
                },
            {
                $group: {
                    _id: null,
                    MIN_TOTAL_COMPENSATION: { $min: "$totalCompensation" }
                    }
                },
            {
                $project: {
                    _id: 0,
                    MIN_TOTAL_COMPENSATION: 1
                    }
                }
            ])

        //28
            db.emps.aggregate([
                {
                    $group: {
                        _id: null,
                        OLDEST_EMPLOYEE_HIRED: { $min: "$HIREDATE" }
                        }
                    },
                {
                    $project: {
                        _id: 0,
                        OLDEST_EMPLOYEE_HIRED: 1
                        }
                    }
                ])

        //29
            db.emps.aggregate([
                {
                    $group: {
                        _id: { dept_id: "$dept_id", JOB: "$JOB" },
                        NUMBER_OF_EMPLOYEES: { $sum: 1 }
                        }
                    },
                {
                    $sort: {
                        "_id.dept_id": 1,
                        "_id.JOB": 1
                        }
                    },
                {
                    $project: {
                        _id: 0,
                        dept_id: "$_id.dept_id",
                        JOB: "$_id.JOB",
                        NUMBER_OF_EMPLOYEES: 1
                        }
                    }
                ]);

        //30
            db.emps.aggregate([
                {
                    $group: {
                        _id: "$dept_id",
                        MAX_INCOME: {
                            $max: {
                                $add: [
                                    "$SAL",
                                    { $ifNull: ["$COMM", 0] }
                                    ]
                                }
                            }
                        }
                    },
                {
                    $group: {
                        _id: null,
                        LOWEST_MAX_INCOME: { $min: "$MAX_INCOME" }
                        }
                    },
                {
                    $project: {
                        _id: 0,
                        LOWEST_MAX_INCOME: 1
                        }
                    }
                ]);

        //34
            db.emps.aggregate([
                {
                    $match: { dept_id: 30 }
                    },
                {
                    $group: {
                        _id: null,
                        MIN_SALARY: { $min: "$SAL" },
                        MAX_SALARY: { $max: "$SAL" },
                        AVG_SALARY: { $avg: "$SAL" },
                        COUNT_SALARY: { $sum: { $cond: [{ $ne: ["$SAL", null] }, 1, 0] } },
                        MIN_COMM: { $min: "$COMM" },
                        MAX_COMM: { $max: "$COMM" },
                        AVG_COMM: { $avg: "$COMM" },
                        COUNT_COMM: { $sum: { $cond: [{ $ne: ["$COMM", null] }, 1, 0] } }
                        }
                    },
                {
                    $project: {
                        _id: 0,
                        MIN_SALARY: 1,
                        MAX_SALARY: 1,
                        AVG_SALARY: 1,
                        COUNT_SALARY: 1,
                        MIN_COMM: 1,
                        MAX_COMM: 1,
                        AVG_COMM: 1,
                        COUNT_COMM: 1
                        }
                    }
                ]);

            //35
                db.emps.aggregate([
                    {
                        $group: {
                            _id: "$dept_id",
                            MIN_SALARY: { $min: "$SAL" },
                            MAX_SALARY: { $max: "$SAL" },
                            AVG_SALARY: { $avg: "$SAL" }
                            }
                        }
                    ])

            // 37
            db.depts.aggregate([
                    {
                        $lookup: {
                            localField: "DEPTNO",
                            from: "emps",
                            foreignField: "dept_id",
                            as: "mitarbeiter"
                            }
                        },
                    {
                        $unwind: "$mitarbeiter"
                        },
                    {
                        $project: {
                            _id: 0,
                            DEPTNO: 1,
                            DNAME: 1,
                            "mitarbeiter.ENAME": 1
                            }
                        }
                    ])

            // 38

                db.getSiblingDB("htlzwettl").getCollection("emps").aggregate([
                    {
                        $group: {
                            _id: {"dept_id": "$dept_id"},
                            "SUM(SAL*12)": {$sum: {$multiply: ["$SAL", 12]}}
                            }
                        },
                    {
                        $project: {"SUM(SAL*12)": "$SUM(SAL*12)", "_id": 0}
                        }
                    ])

            // 40

                db.emps.aggregate([
                        { $group: { _id: "$JOB", avgSalary: { $avg: "$SAL" } } },
                        { $match: { avgSalary: { $gt: 1500 } } },
                        { $sort: { avgSalary: 1 } },
                        { $project: { _id: 0, JOB: "$_id", avgSalary: 1 } }
                        ]);

            // 41

            db.emps.aggregate([
                    { $match: { JOB: "CLERK" } },
                    { $group: { _id: "$dept_id", clerkCount: { $sum: 1 } } },
                    { $match: { clerkCount: { $gte: 2 } } },
                    { $project: { _id: 0, dept_id: "$_id", clerkCount: 1 } }
                    ]);

            // 43

            db.emps.aggregate([
                { $group: { _id: "$JOB", avgSalary: { $avg: "$SAL" } } },
                { $match: { avgSalary: { $gt: 1500 } } },
                { $sort: { _id: 1 } },  // Sortiert nach JOB (alphabetisch aufsteigend)
                { $project: { _id: 0, JOB: "$_id", avgSalary: 1 } }
                ]);

            // 46

            db.emps.find({ SAL: { $gt: db.emps.findOne({ ENAME: "JONES" }).SAL } }).sort({ SAL: -1 });

                db.emps.findOne({ ENAME: "JONES" }).SAL; // 2975