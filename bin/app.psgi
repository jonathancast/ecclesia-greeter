#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Ecclesia::Greeter;

Ecclesia::Greeter->to_app;
