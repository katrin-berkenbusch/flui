from __future__ import annotations

from enum import IntEnum
from typing import Self


class SegmentTypeError(Exception):
    pass


class SegmentType(IntEnum):
    """These names and numbers are related (not like a normal enum)."""

    PB2 = 1
    PB1 = 2
    PA = 3
    HA = 4
    NP = 5
    NA = 6
    MP = 7
    NS = 8

    def to_string(self):
        """Clearer, as I can never remember this."""
        return self.name

    @classmethod
    def parse(cls, text: str) -> Self:
        """Support parsing of integers or strings."""
        text = text.strip().upper()

        # Try a numeric value first.
        try:
            v = int(text)
        except ValueError:
            pass
        else:
            # It should be a valid value
            try:
                return cls(v)
            except ValueError as e:
                msg = f"{v} is not a valid segment"
                raise SegmentTypeError(msg) from e

        try:
            return cls[text]
        except KeyError as e:
            msg = f"{text} is not a valid segment"
            raise SegmentTypeError(msg) from e
