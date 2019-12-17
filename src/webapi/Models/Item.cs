﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace webapi.Models
{
    public partial class item
    {
        public int UserId { get; set; }
        public int VideoId { get; set; }

        public User User { get; set; }
        public Video Video { get; set; }
    }
}
